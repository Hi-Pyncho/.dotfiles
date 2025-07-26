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

return M
