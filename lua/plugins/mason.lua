-- Mason: installs all tool binaries (LSP servers + formatters)
-- mason-lspconfig: automatically enables installed servers via vim.lsp.enable()
return {
  "mason-org/mason.nvim",
  lazy = false,
  build = ":Mason",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Mason: installs binaries
    require("mason").setup({
      ensure_installed = {
        "stylua",
        "prettier",
        "black",
        "autopep8",
        "shfmt",
        "goimports",
        "gofmt",
        "rustfmt",
        "clang-format",
        "sqlformat",
        "dockerfile-formatter",
      },
    })

    -- mason-lspconfig: installs LSP binaries & auto-enables them via vim.lsp.enable()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "tailwindcss" },
    })

    -- Apply blink.cmp capabilities globally to all LSP servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end,
}
