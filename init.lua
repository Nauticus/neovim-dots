-- Neovim configuration entry point

require("options")
require("keymaps")

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
})

-- LSP (deferred until after lazy.nvim is done loading)
require("lsp")
