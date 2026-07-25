-- Override lua_ls defaults from nvim-lspconfig
-- See :help lsp-config-merge for merge order
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
      },
    },
  },
}
