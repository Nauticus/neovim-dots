-- Neovim configuration entry point

require("options")
require("keymaps")

-- Treesitter highlighting (built into Neovim 0.12)
vim.g.treesitter = {
  highlight = { enable = true },
}

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
require("lazy").setup("plugins")

-- LSP (builtin, works with any server installed via Mason)
require("lsp")
