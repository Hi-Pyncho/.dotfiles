local stringUtils = require('user.luaUtils.string')
local oilHelper = require('user.pluginsHelpers.oil')

vim.keymap.set('n', '<leader>fd', function()
  vim.fn.setreg('+', oilHelper.getFolderPathUnderCursor())
end, { desc = 'Copy current dir path to clipboard' })

vim.keymap.set('n', '<leader>fs', function()
  local filePath = oilHelper.getFilePathUnderCursor()

  if filePath then
    vim.system({ 'du', '-sh', filePath }, { text = true }, function(obj)
      P(stringUtils.split(obj.stdout, '\t')[1])
    end)
  end
end, { desc = 'Show directory size' })

vim.keymap.set('n', '<leader>se', function()
  local search_term = vim.fn.input("Search term: ")
  if search_term ~= "" then
    vim.cmd('silent! grep! "' .. search_term .. '"')
    vim.cmd('copen') -- open quickfix list
  end
end, { desc = 'system grep'} )

vim.keymap.set('n', '<leader>fp', function ()
  local filePath = oilHelper.getFilePathUnderCursor()

  if not vim.fn.executable('feh') then
    vim.notify('install feh for preview image', vim.log.levels.WARN)
    return
  end

  os.execute('feh '..filePath)
end, { desc = 'Preview file' })
