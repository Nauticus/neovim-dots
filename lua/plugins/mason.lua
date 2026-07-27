-- Mason: installs all tool binaries (LSP servers + formatters)
-- mason-lspconfig: connects Mason-installed LSP servers to Neovim
return {
  "mason-org/mason.nvim",
  lazy = false,
  build = ":Mason",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({
      ensure_installed = {
        -- LSP servers
        "copilot",
        "lua_ls",
        "tailwindcss",
        -- Formatters (conform.nvim calls these binaries)
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

    -- Connect Mason LSP servers to Neovim
    -- Note: copilot is excluded — it's started by vim.lsp.enable() in sidekick.nvim spec.
    -- Mason still installs the binary (ensure_installed), but mason-lspconfig doesn't auto-setup.
    require("mason-lspconfig").setup({
      automatic_installation = true,
      handlers = {
        function(server)
          if server == "copilot" then
            return -- handled by sidekick.nvim
          end
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
      },
    })
  end,
}
