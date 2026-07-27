return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- Copilot.vim is a Vim plugin (no Lua setup needed)
    -- Enable copilot in all buffers
    vim.cmd("Copilot enable")
  end,
}
