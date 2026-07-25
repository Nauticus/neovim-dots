return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open parent directory" },
  },
  config = function()
    require("oil").setup()
  end,
}
