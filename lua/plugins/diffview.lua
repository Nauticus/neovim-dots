return {
  "dlyongemallo/diffview-plus.nvim", -- maintained fork with Windows fixes + perf improvements
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = true,
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
    "DiffviewRefresh",
  },
  keys = {
    -- Global keymaps (outside diffview)
    { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (repo)" },
    {
      "<leader>gD",
      function()
        -- Diff against main/master with fallback
        local result = vim.fn.systemlist({ "git", "rev-parse", "--verify", "main" })
        local ok = vim.v.shell_error == 0 and result[1] and result[1] ~= ""
        local branch = ok and "main" or "master"
        vim.cmd("DiffviewOpen " .. branch)
      end,
      desc = "Diff against main/master",
    },
    { "<leader>gl", "<cmd>DiffviewFileHistory --follow<cr>", desc = "Line history" },

  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    show_help_hints = false,
    clean_up_buffers = true,
    auto_close_on_empty = true,
    diffopt = { algorithm = "histogram" },
    default_args = {
      DiffviewOpen = { "--imply-local" },
    },
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff4_mixed", disable_diagnostics = true, winbar_info = true },
      file_history = { layout = "diff2_horizontal" },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { position = "left", width = 35 },
      show_branch_name = true,
      always_show_sections = true,
    },
    file_history_panel = {
      stat_style = "both",
      date_format = "relative",
      commit_format = { "hash", "subject", "author", "date", "status", "stats" },
    },
    keymaps = {
      -- Escape to close diffview (any panel)
      view = { { "n", "<leader>q", "DiffviewClose", { desc = "Close diffview" } } },
      -- File panel keymaps
      file_panel = {
        { "n", "<leader>q", "DiffviewClose", { desc = "Close diffview" } },
        { "n", "<C-d>", "DiffviewRefresh", { desc = "Refresh" } },
        { "n", "<C-f>", "DiffviewToggleFiles", { desc = "Toggle file panel" } },
      },
      -- Diff buffer keymaps
      diff_files = {
        { "n", "<leader>q", "DiffviewClose", { desc = "Close diffview" } },
      },
      -- File history panel keymaps
      file_history_panel = {
        { "n", "<leader>q", "DiffviewClose", { desc = "Close diffview" } },
      },
    },
  },
}
