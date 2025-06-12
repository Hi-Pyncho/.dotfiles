local M = {}

function M.setup(config)
  config = config or {}

  local ruLayout = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'

  for i = 1, #ruLayout do
    local char = string.sub(ruLayout, i, i)
    vim.keymap.set({ 'n', 'v' }, char, function ()
      vim.notify('change layout to EN', vim.log.levels.WARN)
    end, { noremap = true, silent = true })
  end
end

return M
