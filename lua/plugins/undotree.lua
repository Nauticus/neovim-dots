return {
  "mbbill/undotree",
  -- UndoTree reads undo files from disk — pointless with undofile disabled.
  -- Also disabled on Windows where it had issues and is now unused.
  enabled = (vim.fn.has("win32") ~= 1),
  event = "BufReadPost",
  keys = {
    { "<leader>ou", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
  },
}
