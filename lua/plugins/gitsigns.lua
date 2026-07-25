return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      map("n", "<leader>gh", gs.hover, "Git signs hover")
      map("n", "<leader>gb", gs.blame_line, "Git blame line")
      map("n", "<leader>gd", gs.diffthis, "Git diff this")
      map("n", "<leader>gr", gs.reset_hunk, "Git reset hunk")
      map("v", "<leader>gr", gs.reset_hunk, "Git reset hunk (visual)")
      map("n", "<leader>gp", gs.preview_hunk, "Git preview hunk")
      map("n", "<leader>gP", gs.preview_hunk_inline, "Git preview hunk inline")
      map("n", "<leader>gs", gs.stage_hunk, "Git stage hunk")
      map("v", "<leader>gs", gs.stage_hunk, "Git stage hunk (visual)")
      map("n", "<leader>gS", gs.stage_buffer, "Git stage buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Git undo stage hunk")
      map("n", "<leader>grs", gs.reset_buffer, "Git reset buffer")
    end,
  },
}
