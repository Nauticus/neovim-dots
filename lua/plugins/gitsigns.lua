return {
  "lewis6991/gitsigns.nvim",
  event = "User FileLoaded",  -- lazy trigger instead of every BufRead
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    -- On throttled IO machines: reduce update frequency
    -- update_debounce_defaults = { insert = 200, normal = 100, visual = 100 },
    -- or disable auto-updates entirely and only update on demand:
    -- on_attach = function(bufnr) require("gitsigns").notify({ bufnr = bufnr }) end,
    -- Current: use defaults but delay git status calls
    current_line_blame = false,  -- don't auto-trigger blame
    watch_gitdir = {
      interval = 1000,  -- increase poll interval (default 1000, set higher if needed)
    },
    -- Skip large/deep repos to save IO
    -- preview_config = { timeout = 1000 },
    -- signs_staged removed (not defining it = no staged signs, saves git calls)
    signcolumn = true,
    -- watch_git_files was removed; watch_gitdir (above) handles this
    -- Manually trigger updates instead of auto:
    -- Use :Gitsigns refresh or :Gitsigns preview_hunk when needed
    preview_config = {
      style = "minimal",
    },
    -- Reduce number of concurrent git processes
    -- max_file_length = 100000,  -- skip huge files
    -- on_attach (keymaps only, no auto git operations):
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Hunk navigation
      map("n", "]g", function() gs.nav_hunk("next") end, "Git next hunk")
      map("n", "[g", function() gs.nav_hunk("prev") end, "Git prev hunk")

      -- Staging
      map("n", "<leader>gs", function() gs.stage_hunk() end, "Git stage hunk")
      map("v", "<leader>gs", function() gs.stage_hunk() end, "Git stage hunk (visual)")
      map("n", "<leader>gS", function() gs.stage_buffer() end, "Git stage buffer")
      map("n", "<leader>gu", function() gs.undo_stage_hunk() end, "Git undo stage hunk")

      -- Reset
      map("n", "<leader>gr", function() gs.reset_hunk() end, "Git reset hunk")
      map("v", "<leader>gr", function() gs.reset_hunk() end, "Git reset hunk (visual)")
      map("n", "<leader>grs", function() gs.reset_buffer() end, "Git reset buffer")

      -- Preview
      map("n", "<leader>gp", function() gs.preview_hunk() end, "Git preview hunk")
      map("n", "<leader>gP", function() gs.preview_hunk_inline() end, "Git preview hunk inline")

      -- Blame
      map("n", "<leader>gb", function() gs.blame_line() end, "Git blame line")
      map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "Git blame (full)")

      -- Diff
      map("n", "<leader>gd", function() gs.diffthis() end, "Git diff this")
    end,
  },
}
