-- Show a floating window with LSP server info for the current buffer
local M = {}

M.show = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP servers attached to this buffer", vim.msg.warn, { title = "LSP" })
    return
  end

  local lines = { "Attached LSP Servers:", "" }
  for _, client in ipairs(clients) do
    table.insert(lines, string.format("  • %s (v%s)", client.name, client.server_info.version or "unknown"))
  end

  local width = 50
  local height = #lines + 2
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row, col = col,
    width = width, height = height,
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })
end

return M
