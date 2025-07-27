local window = require('user.nvimHelpers.window')

local M = {}

local floatingWindow = window.createFloatingWindow({})

local toggleTerminal = function()
  if floatingWindow.isOpened() then
    floatingWindow.hide()
    return
  end

  local winInfo = floatingWindow.open()

  if vim.bo[winInfo.buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
  end

  vim.api.nvim_command 'startinsert'
end

function M.setup(config)
  config = config or {}

  vim.api.nvim_create_user_command('Floaterminal', toggleTerminal, {})
  vim.keymap.set({ 'n', 't' }, '<leader>tt', toggleTerminal, { desc = 'Toggle terminal' })
end

return M
