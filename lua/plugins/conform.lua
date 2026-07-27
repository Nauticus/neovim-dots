-- conform.nvim: lightweight formatting plugin
-- Uses Prettier for JS/TS/JSON/CSS/Markdown etc.
-- Uses StyLua for Lua files

return {
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format File",
    },
    {
      "<leader>cF",
      function()
        require("conform").format({ lsp_fallback = true, async = false })
      end,
      mode = "n",
      desc = "Format File (blocking)",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- format_on_save writes the file on every save.
      -- On IO-throttled machines, consider disabling and using <leader>cf manually.
      -- Windows note: prettier (Node.js) has cold-start overhead, 500ms won't cut it.
      format_on_save = {
        timeout_ms = (vim.fn.has("win32") == 1) and 3000 or 500,
        lsp_fallback = true,
      },
      -- On heavily throttled machines, uncomment this to disable auto-format on save:
      -- format_on_save = false,

      -- Log noisy output (debug only)
      log_level = vim.log.levels.ERROR,

      formatters_by_ft = {
        -- Lua: use stylua (conform can install it)
        lua = { "stylua" },

        -- JavaScript / TypeScript / JSON / CSS / Markdown / YAML / HTML / GraphQL
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        svelte = { "prettier" },
        vue = { "prettier" },

        -- Python
        python = { "black", "autopep8", fallback = true },

        -- Shell scripts
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Go
        go = { "goimports", "gofmt" },

        -- Rust
        rust = { "rustfmt" },

        -- C / C++
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Java
        java = { "clang_format" },

        -- SQL
        sql = { "sqlformat" },

        -- Dockerfile
        dockerfile = { "dockerfile-formatter" },

        -- Twig
        twig = { "crystal" },

        -- HTML alternative
        -- html = { "htmlbeautify" },
      },

      -- Global formatter options
      formatters = {
        ["clang_format"] = {
          args = { "--style=llvm" },
        },
        ["sqlformat"] = {
          args = { "--reindent", "--keyword-case=upper", "--identifiers=lower" },
        },
      },
    })

    -- Formatters are installed by Mason (see lua/plugins/mason.lua).
    -- conform.nvim just calls those binaries. Check status: :ConformInfo
  end,
}
