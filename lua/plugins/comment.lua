-- Comment.nvim — Smart commenting with gc/gbc, motions, dot repeat
-- gcc = toggle line comment, gbc = toggle block comment
-- gcw/gc$/gc5j = motion-based commenting
-- gco/gcO/gcA = insert commented line below/above/at end
-- Docs: :help comment-nvim

return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- better tsx/jsx support
  },
  event = "VeryLazy",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
