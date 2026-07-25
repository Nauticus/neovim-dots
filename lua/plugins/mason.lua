-- Mason: install LSP server + formatter binaries
-- nvim-lspconfig: provides lsp/*.lua config files for all servers
-- mason-lspconfig: auto-enables servers when Mason installs them
return {
  "mason-org/mason.nvim",
  lazy = false,
  build = ":Mason",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({})

    -- Auto-enable all Mason-installed LSP servers
    require("mason-lspconfig").setup({
      ensure_installed = {}, -- add servers here for auto-install on start
      automatic_installation = true, -- auto-install when opening a supported file
      handlers = {
        function(server)
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
      },
    })
  end,
}
