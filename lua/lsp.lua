-- LSP keymaps and diagnostics config
-- Server configs are in: after/lsp/<name>.lua
-- All servers auto-enabled by mason-lspconfig

-- Neovim 0.12 builtin LSP keymaps (no plugin needed):
--   gra  = code action    |  grn  = rename         |  grr  = references
--   gri  = implementation |  grt  = type definition|  gO   = document symbols
--   gx   = open link      |  gq   = format lines   |  Ctrl-S = signature help
--   CTRL-] = go to def (via tagfunc)                |  K    = hover docs
--
-- Buffer-local keymaps added on LspAttach:
--   gd/gD  = go to definition                       |  <leader>la = code action
--   <leader>ld = go to definition                   |  <leader>lr = rename
--   CursorHold = document highlight (LspReference*) |  CursorMoved = clear
--
-- Extra LSP keymaps under <leader>l
-- Note: formatting is handled by conform.nvim (<leader>cf)

-- Diagnostic navigation (global)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Track configured buffers to avoid stacking on multi-client attach
    local meta = vim.tbl_get(vim, "_user_lsp", "configured")
    if not meta then
      meta = {}
      vim._user_lsp = { configured = meta }
    end
    if meta[bufnr] then
      return
    end
    meta[bufnr] = true

    -- Go to definition (gd/gD)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition (from line 1)" })

    -- Code actions under <leader>l
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })

    -- Document highlight (LspReference* groups) on CursorHold, clear on move
    -- Check at runtime whether any attached client supports the method
    local function has_document_highlight()
      for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if c:supports_method("textDocument/documentHighlight") then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("UserLspHighlight_" .. bufnr, { clear = true }),
      callback = function()
        if has_document_highlight() then
          vim.lsp.buf.document_highlight()
        end
      end,
      desc = "Highlight document references",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("UserLspClear_" .. bufnr, { clear = true }),
      callback = vim.lsp.buf.clear_references,
      desc = "Clear document references",
    })

    -- Force mini.clue to re-index triggers so buffer-local keymaps are picked up
    pcall(function()
      require("mini.clue").ensure_buf_triggers(bufnr)
    end)
  end,
})

-- Diagnostic virtual text (inline error/warning hints)
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  underline = true,
  signs = true,
  severity_sort = true,
})

--- LSP IO-Reduction Options (for throttled work machines) -----------------------------
-- LSP servers can be heavy IO writers: they create caches, indexes, and logs.
-- These are set in the LspAttach callback so all servers inherit them.

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspIoOptimization", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- Disable LSP file watching (reduces inotify/FS watcher pressure)
    -- Some servers create file watchers for every file in the project
    -- client.config.capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

    -- Reduce LSP logging verbosity (LSP servers write their own logs)
    -- Set per-server in after/lsp/<name>.lua if needed:
    --   settings = { <server> = { logLevel = "warn" } }
  end,
})

-- Optional: point LSP caches to RAM disk on Linux
-- Uncomment and adjust path for your system:
-- local ramdisk = "/dev/shm/nvim-lsp-caches"
-- vim.fn.mkdir(ramdisk, "p")
-- Then set per-server:
--   { memento = { workspace = { storage = ramdisk } } }  -- typescript
--   { rust_analyzer = { diagnostics = { enable = false } } } -- rust (heavy)
