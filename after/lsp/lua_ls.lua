-- Override lua_ls defaults from nvim-lspconfig
-- See :help lsp-config-merge for merge order
--
-- lazydev.nvim handles workspace library configuration dynamically.
-- No manual library.path is needed beyond this config directory.

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- Additional runtime libraries beyond what LuaDev provides
          vim.fn.expand "$HOME/.config/nvim"},
      },
    },
  },
}
