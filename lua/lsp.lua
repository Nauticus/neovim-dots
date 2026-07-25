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
  { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename Symbol" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeys", { clear = true }),
  callback = function(event)
    local wk = require("which-key")
    -- Register extra LSP keymaps
    for _, mapping in ipairs(keymaps) do
      vim.keymap.set("n", mapping[1], mapping[2], {
        buffer = event.buf,
        desc = mapping[3],
      })
    end
    -- Register which-key hints for builtin + custom LSP keys (only when LSP is active)
    wk.add({
      { "[d", desc = "Previous Diagnostic", mode = "n", buffer = event.buf },
      { "]d", desc = "Next Diagnostic", mode = "n", buffer = event.buf },
      { "gO", desc = "Document Symbols", mode = "n", buffer = event.buf },
      { "gra", desc = "Code Action", mode = "n", buffer = event.buf },
      { "gri", desc = "Go to Implementation", mode = "n", buffer = event.buf },
      { "grn", desc = "Rename", mode = "n", buffer = event.buf },
      { "grr", desc = "Go to References", mode = "n", buffer = event.buf },
      { "grt", desc = "Go to Type Definition", mode = "n", buffer = event.buf },
      { "gq", desc = "Format Lines", mode = "n", buffer = event.buf },
      { "<leader>ld", desc = "Go to Definition", mode = "n", buffer = event.buf },
      { "<leader>lr", desc = "Rename Symbol", mode = "n", buffer = event.buf },
      { "<leader>la", desc = "Code Action", mode = "n", buffer = event.buf },
    })
  end,
})

-- Diagnostic virtual text (inline error/warning hints)
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  underline = true,
  signs = true,
  severity_sort = true,
})
