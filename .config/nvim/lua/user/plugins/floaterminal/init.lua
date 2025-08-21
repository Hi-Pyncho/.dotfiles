local window = require('user.nvimHelpers.window')

local M = {}
local floatingWindow = window.createFloatingWindow({})

local function closeTerminalsOnRestoreSession(excludeBuf)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufName = vim.api.nvim_buf_get_name(buf)
      local isTerminal = string.match(bufName, 'term://')

      if (isTerminal and buf ~= excludeBuf) then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end
end

---@param opts { openInCurrentDir?: boolean }
local toggleTerminal = function(opts)
  opts = opts or {}
  local filename = vim.fn.shellescape(vim.fn.expand('%:p:h'))
  local command = 'cd ' .. filename .. '\n'

  if floatingWindow.isOpened() then
    floatingWindow.hide()
    return
  end

  local winInfo = floatingWindow.open()

  closeTerminalsOnRestoreSession(winInfo.buf)

  if vim.bo[winInfo.buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
  end

  vim.api.nvim_command 'startinsert'

  if (opts.openInCurrentDir) then
    vim.api.nvim_feedkeys('\n', 'n', false)
    vim.api.nvim_feedkeys(command, 'n', false)
  end
end

function M.setup(config)
  config = config or {}

  vim.api.nvim_create_user_command('Floaterminal', toggleTerminal, {})
  vim.keymap.set({ 'n', 't' }, '<leader>tt', toggleTerminal, { desc = 'Toggle terminal' })
  vim.keymap.set({ 'n', 't' }, '<leader>tp', function ()
    toggleTerminal({ openInCurrentDir = true })
  end, { desc = 'Toggle terminal in the current directory' })
end

return M
