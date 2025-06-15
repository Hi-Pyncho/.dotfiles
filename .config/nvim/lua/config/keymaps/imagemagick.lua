local oilHelper = require('user.pluginsHelpers.oil')
local stringUtils = require('user.luaUtils.string')

vim.keymap.set('n', '<leader>ii', function()
  local file = oilHelper.getFilePathUnderCursor()

  local function identify(flag)
    flag = flag or ''

    vim.system({ 'magick', 'identify', flag, file }, { text = true }, function (obj)
      vim.notify(obj.stdout)
    end)
  end

  vim.ui.select({ 'short', 'verbose' }, {
    prompt = 'Print short info or verbose?',
  }, function(choice)
    if choice == 'verbose' then
      identify('-verbose')
    else
      identify()
    end
  end)

end, { desc = 'Image info' })

-- vim.keymap.set('n', '<leader>ir', function ()
--   local dirpath = oilHelper.
-- end, { desc = '' })
