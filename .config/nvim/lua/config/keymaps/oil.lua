local stringUtils = require('user.luaUtils.string')
local oilHelper = require('user.pluginsHelpers.oil')

vim.keymap.set('n', '<leader>fpd', function()
  vim.fn.setreg('+', oilHelper.getFolderPathUnderCursor())
end, { desc = 'Copy current dir path to clipboard' })

vim.keymap.set('n', '<leader>fpf', function()
  vim.fn.setreg('+', oilHelper.getFilePathUnderCursor())
end, { desc = 'Copy current file path to clipboard' })

vim.keymap.set('n', '<leader>fu', function()
  local dirPath = oilHelper.getFolderPathUnderCursor()
  local filename = oilHelper.getFilenameUnderCursor()
  local filepath = dirPath..filename

  vim.ui.input({
    prompt = 'Enter directory name for extracting files: ',
    default = filename
  }, function (dirname)
    assert(not stringUtils.isEmpty(dirname), 'Directory name is required')

    vim.system({ 'unzip', filepath, '-d', dirPath..dirname })
  end)

end, { desc = 'Copy current file path to clipboard' })

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

vim.keymap.set('n', '<leader>ip', function ()
  local filePath = oilHelper.getFilePathUnderCursor()

  if not vim.fn.executable('feh') then
    vim.notify('install feh for preview image', vim.log.levels.WARN)
    return
  end

  os.execute('feh '..filePath)
end, { desc = 'Preview file', noremap = true })
