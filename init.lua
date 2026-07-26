-- Neovim configuration entry point

require("options")
require("keymaps")

-- Lazy-load plugins after a short delay (reduces startup IO burst)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("LazyPluginTrigger", { clear = true }),
  once = true,
  callback = function()
    -- Fire after 500ms to batch file opens
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "FileLoaded" })
    end, 500)
  end,
})

-- Install Lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  spec = "plugins",
  change_detection = { notify = false },
  rocks = { enabled = false },
  performance = {
    rtp = {
      paths = {
        vim.env.VIMRUNTIME .. "/pack/dist/opt/nvim.undotree",
      },
    },
  },
})

-- Source undotree plugin after lazy rtp setup
vim.cmd("runtime! pack/dist/opt/nvim.undotree/plugin/*.lua")

-- LSP (deferred until after lazy.nvim is done loading)
require("lsp")
