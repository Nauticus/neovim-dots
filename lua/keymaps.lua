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
local lsp_info = require("lsp_info")
vim.keymap.set("n", "<leader>li", lsp_info.show, { desc = "LSP: Info" })

-- Built-in undotree (Neovim 0.12+) — opens if closed, closes if open
vim.keymap.set("n", "<localleader>u", "<Cmd>Undotree<CR>", { desc = "Toggle UndoTree" })
vim.keymap.set("i", "<localleader>u", "<Esc><Cmd>Undotree<CR>", { desc = "Toggle UndoTree" })

-- ======================================================================
-- Toggle helpers
-- ======================================================================

--- Toggle a boolean option and print the new state.
local function toggle_bool(opt)
  vim.opt[opt] = not vim.opt[opt]:get()
  vim.notify(string.format("%s: %s", opt, vim.opt[opt]:get() and "on" or "off"), vim.log.INFO, { title = "Option" })
end

--- Cycle a value through a list of choices.
local function cycle(opt, choices)
  local current = vim.opt[opt]:get()
  local idx = 0
  for i, v in ipairs(choices) do
    if vim.inspect(current) == vim.inspect(v) then
      idx = i
      break
    end
  end
  local next_val = choices[idx % #choices + 1]
  vim.opt[opt] = next_val
  vim.notify(string.format("%s: %s", opt, vim.inspect(next_val)), vim.log.INFO, { title = "Option" })
end

-- ======================================================================
-- Toggle keymaps (localleader + letter)
-- ======================================================================

vim.keymap.set("n", "<localleader>tr", function()
  toggle_bool("relativenumber")
end, { desc = "Toggle: Relative line numbers" })
vim.keymap.set("n", "<localleader>tn", function()
  toggle_bool("number")
end, { desc = "Toggle: Line numbers" })
vim.keymap.set("n", "<localleader>tw", function()
  toggle_bool("wrap")
end, { desc = "Toggle: Word wrap" })
vim.keymap.set("n", "<localleader>tc", function()
  toggle_bool("cursorline")
end, { desc = "Toggle: Cursor line" })
vim.keymap.set("n", "<localleader>tl", function()
  toggle_bool("list")
end, { desc = "Toggle: Whitespace (list)" })

vim.keymap.set("n", "<localleader>tL", function()
  cycle("listchars", {
    { trail = "-" },                                         -- trailing only
    { trail = "-", space = "·" },                            -- trailing + all spaces
    { trail = "-", space = "·", tab = "▸ " },               -- trailing + spaces + tabs
  })
end, { desc = "Cycle: Listchars (whitespace markers)" })
vim.keymap.set("n", "<localleader>ts", function()
  toggle_bool("spell")
end, { desc = "Toggle: Spell check" })
vim.keymap.set("n", "<localleader>tp", function()
  toggle_bool("paste")
end, { desc = "Toggle: Paste mode" })
vim.keymap.set("n", "<localleader>tb", function()
  cycle("background", { "dark", "light" })
end, { desc = "Toggle: Background (dark/light)" })

vim.keymap.set("n", "<localleader>tC", function()
  cycle("conceallevel", { 0, 1, 2, 3 })
end, { desc = "Cycle: Conceal level" })

vim.keymap.set("n", "<localleader>tg", function()
  cycle("colorcolumn", { "", "80", "100", "120", "80,100,120" })
end, { desc = "Cycle: Color column (guide)" })

vim.keymap.set("n", "<localleader>ti", function()
  cycle("signcolumn", { "auto", "yes", "no" })
end, { desc = "Cycle: Sign column" })
