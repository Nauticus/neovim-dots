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

vim.opt.list = true -- show trailing whitespace (trail: -), tabs, etc.

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.clipboard = (vim.fn.has("clipboard") == 1) and "unnamedplus" or ""

-- Default floating window border (applies to all floats unless overridden)
-- Options: "none", "single", "double", "rounded", "bold", "shadow", "solid"
-- Custom: comma-separated 8 chars clockwise from topleft, e.g. "+,-,+,|,+,-,+,|"
vim.opt.winborder = "rounded"

-- Transparent background for main window and floating windows
-- (requires terminal/GUI with transparent background)
-- Applied immediately AND on ColorScheme event (triggers on any theme switch)
local function set_transparency()
  vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
  vim.cmd([[highlight NormalFloat guibg=NONE ctermbg=NONE]])
  vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
  vim.cmd([[highlight FloatBorder guibg=NONE ctermbg=NONE]])
  vim.cmd([[highlight Pmenu guibg=NONE ctermbg=NONE]])
  vim.cmd([[highlight PmenuSel guibg=NONE ctermbg=NONE]])
end
set_transparency()
-- Schedule to run after pending highlights apply, preventing theme overrides
vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(set_transparency) })

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

-- Persistent undo enabled (required for cross-session :Undotree history)
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
-- Note: nvim.undotree is loaded in init.lua AFTER lazy.nvim setup

-- IO reduction
vim.opt.updatetime = 500 -- CursorHold trigger (document highlight), swap file write
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
-- Per :help *shell-pwsh*: don't override shellpipe/shellredir — neovim auto-detects
-- "pwsh" and sets "2>&1| tee" / ">" defaults which work correctly in pwsh.
-- shellcmdflag adds $PSStyle.OutputRendering to prevent ANSI escape issues.
if vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-NoProfile -Command $PSStyle.OutputRendering = 'PlainText';"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.o.shelltemp = false
  vim.o.shellslash = true
  -- Workaround for pwsh ANSI escape sequences (may not be needed in pwsh 7+)
  vim.env.__SuppressAnsiEscapeSequences = "1"
end
