-- blink.cmp: performant, batteries-included completion plugin
return {
  "saghen/blink.cmp",
  version = "1.*", -- use release tags for pre-built binaries
  dependencies = { "rafamadriz/friendly-snippets" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = { auto_show = false },
      menu = { draw = { gap_column = 1, use_nvim_highlight = true } },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- Trigger completion
    completion.trigger = {
      show_documentation = true,
    },
  },
  opts_extend = { "sources.default" },
}
