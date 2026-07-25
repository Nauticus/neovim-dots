-- blink.cmp: performant, batteries-included completion plugin
return {
  "saghen/blink.cmp",
  version = "1.*", -- use release tags for pre-built binaries
  dependencies = { "rafamadriz/friendly-snippets" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        "snippet_forward",
        function() -- sidekick NES: jump to next edit or apply current one
          return require("sidekick").nes_jump_or_apply()
        end,
        function() -- native inline completion (optional)
          return vim.lsp.inline_completion.get()
        end,
        "fallback",
      },
    },
    -- <C-y> to accept, <Tab>/<S-Tab> for snippet placeholders
    -- <C-Space> toggle menu/docs, <C-n>/<C-p> or <Up>/<Down> navigate
    -- <C-e> hide menu, <C-k> toggle signature help

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = { auto_show = true },
      menu = { draw = { gap = 1 } },
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
