return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (cursor)" },
    { "<leader>D", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Buffer Diagnostics" },
    { "<leader>dw", function() require("trouble").toggle({ mode = "diagnostics", filter = { severity = vim.diagnostic.severity.WARN } }) end, desc = "Warnings" },
  },
}
