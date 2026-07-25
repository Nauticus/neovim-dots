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

      map("n", "<leader>gh", function()
        gs.blame_line({ full = true })
      end, "Git blame hover")
      map("n", "<leader>gb", function()
        gs.blame_line()
      end, "Git blame line")
      map("n", "<leader>gd", function()
        gs.diffthis()
      end, "Git diff this")
      map("n", "<leader>gr", function()
        gs.reset_hunk()
      end, "Git reset hunk")
      map("v", "<leader>gr", function()
        gs.reset_hunk()
      end, "Git reset hunk (visual)")
      map("n", "<leader>gp", function()
        gs.preview_hunk()
      end, "Git preview hunk")
      map("n", "<leader>gP", function()
        gs.preview_hunk_inline()
      end, "Git preview hunk inline")
      map("n", "<leader>gs", function()
        gs.stage_hunk()
      end, "Git stage hunk")
      map("v", "<leader>gs", function()
        gs.stage_hunk()
      end, "Git stage hunk (visual)")
      map("n", "<leader>gS", function()
        gs.stage_buffer()
      end, "Git stage buffer")
      map("n", "<leader>gu", function()
        gs.undo_stage_hunk()
      end, "Git undo stage hunk")
      map("n", "<leader>grs", function()
        gs.reset_buffer()
      end, "Git reset buffer")
    end,
  },
}
