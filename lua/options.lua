-- General Options
vim.g.mapleader = " "

-- Appearance & indentation
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Misc
vim.opt.termguicolors = true
vim.opt.clipboard = (vim.fn.has('clipboard') == 1) and 'unnamedplus' or ''

--- WINDOWS-SPECIFIC START --------------------------------------------------------------------
-- Everything between these markers is Windows-only. Delete this block if you don't need it.
--
-- Doc references:
--   |provider-clipboard|  clipboard tools (win32yank, clip, putclip)
--   |shell-powershell|    PowerShell shell config (UTF-8 encoding)
--   |vim.system()|        preferred over vim.fn.system() on Windows
--   |tui.txt|             Windows terminal types (vtpcon, win32con, conemu)
--   |'shellslash'|        backslash vs forward slash in shell paths
--   |'termguicolors'|     24-bit RGB (auto-detected; may fail on legacy console)
--   |starting.txt|        Windows data dirs: ~/AppData/Local/nvim
--   |'cdhome'|            off by default on Windows (|starting.txt| line 1290)
if vim.fn.has('win32') == 1 then
  -- pwsh (PowerShell 7) shell config — minimal flags to avoid Defender heuristics
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag = '-NoProfile -Command '
  vim.o.shellpipe = '> %s 2>&1'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
  vim.o.shelltemp = false
end
--- WINDOWS-SPECIFIC END ----------------------------------------------------------------------
