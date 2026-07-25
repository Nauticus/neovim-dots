-- LSP keymaps and diagnostics config
-- Server configs are in: after/lsp/<name>.lua
-- All servers auto-enabled by mason-lspconfig

-- Neovim 0.12 builtin LSP keymaps (no plugin needed):
--   gra  = code action    |  grn  = rename         |  grr  = references
--   gri  = implementation |  grt  = type definition|  gO   = document symbols
--   gd   = go to def      |  K    = hover docs     |  Ctrl-S = signature help
--   gx   = open link      |  gq   = format lines
--
-- Extra LSP keymaps under <leader>l
-- Note: formatting is handled by conform.nvim (<leader>cf)
local keymaps = {
  { "[d", function() vim.diagnostic.jump({ count = -1 }) end, desc = "Previous Diagnostic" },
  { "]d", function() vim.diagnostic.jump({ count = 1 }) end, desc = "Next Diagnostic" },
  { "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename Symbol" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeys", { clear = true }),
  callback = function(event)
    -- Register extra LSP keymaps
    -- mini.clue picks up descriptions from vim.keymap.set({ desc = ... }) automatically
    for _, mapping in ipairs(keymaps) do
      vim.keymap.set("n", mapping[1], mapping[2], {
        buffer = event.buf,
        desc = mapping[3],
      })
    end
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
    if not client then return end

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
