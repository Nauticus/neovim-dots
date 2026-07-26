return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    ai = {
      -- Incremental selection (visual mode) like vim-expand-region
      -- Defaults an/in/al/il conflict with treesitter textobjects
      selection_keys = {
        around_next  = '<C-a>',  -- expand selection
        inside_next  = '<C-a>',
        around_last  = '<C-x>',  -- shrink selection
        inside_last  = '<C-x>',
      },
    },
    clue = {
      window = { delay = 100 },

      clues = {
        -- Leader key groups
        { mode = "n", keys = "<leader>a", desc = "Clanker" },
        { mode = "n", keys = "<leader>c", desc = "Code" },
        { mode = "n", keys = "<leader>f", desc = "Find" },
        { mode = "n", keys = "<leader>g", desc = "Git" },
        { mode = "n", keys = "<leader>l", desc = "LSP" },
        { mode = "n", keys = "<leader>o", desc = "Other" },

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
          local diff = statusline.section_diff({ trunc_width = 75 })
          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local lsp = statusline.section_lsp({ trunc_width = 75, icon = "󰰎" })
          local filename = statusline.section_filename({ trunc_width = 140 })
          local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
          local git_branch = statusline.section_git({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { diagnostics, lsp } },
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = "MiniStatuslineDevinfo", strings = { diff, git_branch } },
          })
        end,
      },
    },
  },
  config = function(_, opts)
    local mini_ai = require("mini.ai")
    local mini_clue = require("mini.clue")
    local mini_statusline = require("mini.statusline")

    -- MiniAi (textobjects + incremental selection)
    mini_ai.setup(opts.ai)

    -- Add built-in clue generators
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

    -- Add leader trigger
    mini_clue.setup(vim.tbl_deep_extend("force", opts.clue, {
      triggers = {
        { mode = { "n", "x" }, keys = "<Leader>" },
        { mode = { "n", "x" }, keys = "<LocalLeader>" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "z" },
        { mode = "n", keys = "<C-w>" },
        { mode = "i", keys = "<C-x>" },
      },
    }))

    -- Setup statusline
    mini_statusline.setup(opts.statusline)
  end,
}
