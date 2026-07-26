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
      ensure_installed = { "lua_ls", "tailwindcss" }, -- add servers here for auto-install on start
      -- On IO-throttled machines: disable automatic installation.
      -- Auto-installing LSP servers spawns processes and writes on every new file type.
      -- Set to false and manually :Mason install servers you need.
      automatic_installation = true,
      handlers = {
        function(server)
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
      },
    })
  end,
}
