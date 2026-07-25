return {
  "mbbill/undotree",
  event = "BufReadPost",
  config = function()
    if vim.fn.has("win32") == 1 then
      vim.g.undotree_DiffAutoOpen = 0
      -- or point to a diff.exe if you want the diff panel:
      -- vim.g.undotree_DiffCommand = "C:\\Program Files\\Git\\usr\\bin\\diff.exe"
    end

    vim.keymap.set("n", "<leader>ou", "<cmd>UndotreeToggle<cr>", { desc = "UndoTree" })
  end,
}
