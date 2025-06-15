local reindent = require 'user.functions.reindent'

vim.keymap.set({ 'n', 'v' }, '<leader>fx', function ()
  local filetype = vim.bo.filetype

  if filetype == 'lua' then
    vim.cmd('w')
    vim.cmd('source %')
  end

  if filetype == 'javascript' then
    vim.cmd('!node %')
  end

end, { desc = 'Execute current file' })

vim.keymap.set({'n', 'v'}, '<leader>fi', function()
  -- Для нормального режима
  if vim.api.nvim_get_mode().mode == 'n' then
    reindent()
  else
    -- Для визуального режима передаем диапазон
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    reindent({range = 1, line1 = start_line, line2 = end_line})
  end
end, {desc = "Reindent file or selection"})

vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- P(vim.fn.expand('%:t:r'))
-- P(vim.fn.expand("%:p"))
