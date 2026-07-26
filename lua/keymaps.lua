-- Helpers (Windows overrides defined below)
local move_keys = { "h", "j", "k", "l" }

--- WINDOWS-SPECIFIC START --------------------------------------------------------------------
if vim.fn.has("win32") == 1 then
  -- <C-h> maps to backspace in Windows terminals; use uppercase instead
  move_keys = { "H", "J", "K", "L" }
end
--- WINDOWS-SPECIFIC END ----------------------------------------------------------------------

-- Better window navigation
vim.keymap.set("n", "<C-" .. move_keys[1] .. ">", "<C-w>h")
vim.keymap.set("n", "<C-" .. move_keys[2] .. ">", "<C-w>j")
vim.keymap.set("n", "<C-" .. move_keys[3] .. ">", "<C-w>k")
vim.keymap.set("n", "<C-" .. move_keys[4] .. ">", "<C-w>l")

-- Clear search highlights on Esc
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- Oil.nvim keymap is defined in lua/plugins/oil.lua (keys spec)

-- LSP info panel (shows attached servers)
vim.keymap.set("n", "<leader>li", "<Cmd>LspInfo<CR>", { desc = "LSP: Info" })

-- Built-in undotree (Neovim 0.12+) — opens if closed, closes if open
vim.keymap.set("n", "<localleader>u", "<Cmd>Undotree<CR>", { desc = "Toggle UndoTree" })
vim.keymap.set("i", "<localleader>u", "<Esc><Cmd>Undotree<CR>", { desc = "Toggle UndoTree" })
