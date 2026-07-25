-- LazyDev: faster LuaLS setup for Neovim config editing
-- Lazily updates workspace libraries for require() and @module annotations.
-- Replaces neodev.nvim (deprecated).
return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- Load luvit types when `vim.uv` is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Plugins resolved automatically from lazy.nvim
      "lazy.nvim",
      "mini.nvim",
      "oil.nvim",
      "sidekick.nvim",
    },
  },
}
