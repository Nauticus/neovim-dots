return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    clue = {
      -- Show clues after a short delay (in ms)
      window = { delay = 100 },

      clues = {
        -- Custom clues for leader key groups (normal mode)
        { mode = "n", keys = "<leader>a", desc = "Clanker" },
        { mode = "n", keys = "<leader>c", desc = "Code" },
        { mode = "n", keys = "<leader>f", desc = "Find" },
        { mode = "n", keys = "<leader>g", desc = "Git" },
        { mode = "n", keys = "<leader>l", desc = "LSP" },
        { mode = "n", keys = "<leader>o", desc = "Other" },

        -- Same groups in visual mode
        { mode = "x", keys = "<leader>a", desc = "Clanker" },
        { mode = "x", keys = "<leader>c", desc = "Code" },
        { mode = "x", keys = "<leader>f", desc = "Find" },
        { mode = "x", keys = "<leader>g", desc = "Git" },
        { mode = "x", keys = "<leader>l", desc = "LSP" },
        { mode = "x", keys = "<leader>o", desc = "Other" },
      },
    },
    statusline = {
      content = {
        active = function()
          local statusline = require("mini.statusline")
          local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
          local git = statusline.section_git({ trunc_width = 40 })
          local diff = statusline.section_diff({ trunc_width = 75 })
          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local lsp = statusline.section_lsp({ trunc_width = 75 })
          local filename = statusline.section_filename({ trunc_width = 140 })
          local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
          local location = statusline.section_location({ trunc_width = 75 })
          local search = statusline.section_searchcount({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    },
  },
  config = function(_, opts)
    local mini_clue = require("mini.clue")
    local mini_statusline = require("mini.statusline")

    -- Add built-in clue generators (must be in config where mini_clue is available)
    local built_in_clues = {
      mini_clue.gen_clues.square_brackets(),
      mini_clue.gen_clues.g(),
      mini_clue.gen_clues.z(),
      mini_clue.gen_clues.windows({
        submode_move = true,
        submode_navigate = true,
        submode_resize = true,
      }),
      mini_clue.gen_clues.builtin_completion(),
    }
    opts.clue.clues = vim.list_extend(built_in_clues, opts.clue.clues)

    -- Add leader trigger (clues show automatically on trigger key press)
    mini_clue.setup(vim.tbl_deep_extend("force", opts.clue, {
      triggers = {
        -- Leader key
        { mode = { "n", "x" }, keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- `g` key
        { mode = { "n", "x" }, keys = "g" },

        -- `z` key
        { mode = { "n", "x" }, keys = "z" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },
      },
    }))

    -- Setup statusline
    mini_statusline.setup(opts.statusline)
  end,
}
