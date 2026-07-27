return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  config = function()
    require("sidekick").setup({
      nes = { enabled = false },
      cli = {
        tools = {
          pi = {
            cmd = { "pi" },
          },
        },
        context = {
          messages = function()
            return vim.fn.execute("messages")
          end,
        },
        prompts = {
          messages = function()
            local msgs = vim.fn.execute("messages"):match("^%s*(.*)")
            if msgs and msgs ~= "" then
              return "What do these Neovim messages mean?\n" .. msgs
            end
            return "Show me my Neovim messages." -- fallback when empty
          end,
        },
      },
    })
  end,
  keys = {
    {
      "<leader>aa",
      function()
        require("sidekick.cli").select()
      end,
      desc = "Select CLI Tool",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").toggle({ name = "pi", focus = true })
      end,
      desc = "Toggle Pi",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "copilot", focus = true })
      end,
      desc = "Toggle Copilot CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "n", "x" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = "x",
      desc = "Send Selection",
    },
    {
      "<leader>am",
      function()
        require("sidekick.cli").send({ msg = "{messages}" })
      end,
      desc = "Send Messages",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "t", "i", "x" },
      desc = "Focus CLI",
    },
  },
}
