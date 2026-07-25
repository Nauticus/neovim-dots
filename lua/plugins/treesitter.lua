return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "markdown", "markdown_inline", -- core
        "javascript", "typescript", "tsx", "jsx", "svelte", -- web / react
        "python", "toml", -- python dev
      })
    end,
  },
}
