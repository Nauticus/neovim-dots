return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "tsx",
        "jsx",
        "svelte",
        "python",
        "toml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
