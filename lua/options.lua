vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.ttimeoutlen = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.clipboard = (vim.fn.has("clipboard") == 1) and "unnamedplus" or ""

-- Disable unused builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_man = 1
vim.g.loaded_tutor_mode_plugin = 1

-- Mini.clue highlights (ensure descriptions are visible in default dark theme)
vim.api.nvim_set_hl(0, "MiniClueDescSingle", { fg = "#d4d4d4" })
vim.api.nvim_set_hl(0, "MiniClueDescGroup", { fg = "#d4d4d4" })

-- Persistent undo disabled (IO-throttled machines)
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = false

-- IO reduction
vim.opt.updatetime = 500   -- CursorHold trigger (document highlight), swap file write
vim.opt.updatecount = 1000
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
vim.opt.backup = false
vim.opt.backupcopy = "auto"

vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "indent-heuristic",
  "algorithm:histogram",
  "inline:word",
  "context:3",
  "foldcolumn:3",
  "linematch:60",
  "iwhiteeol",
  "hiddenoff",
  "vertical",
}

-- Windows: pwsh shell config
if vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-NoProfile -Command "
  vim.o.shellpipe = "> %s 2>&1"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.o.shelltemp = false
  vim.o.shellslash = true
end
