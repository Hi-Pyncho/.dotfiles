local misc = require('user.luaUtils.misc')
local stringUtil = require('user.luaUtils.string')

local M = {}

function M.createTempFile()
  vim.ui.input({ prompt = 'Enter a file extension' }, function (input)
    local filename = misc.uniqueId()

    if (not stringUtil.isEmpty(input)) then
      filename = filename .. '.' .. input
    end

    local command = 'edit /tmp/' .. filename

    vim.api.nvim_command(command)
  end)
end

---@param command string // use %s as filename replacer
function M.executeAndPrint(command)
  vim.cmd('write')
  local filename = vim.fn.expand('%')
  local cmd = string.format(command, vim.fn.shellescape(filename))
  local output = vim.fn.system(cmd)
  -- Очищаем экран от сообщения о команде
  vim.cmd('redraw!')
  print(output)
end

return M
