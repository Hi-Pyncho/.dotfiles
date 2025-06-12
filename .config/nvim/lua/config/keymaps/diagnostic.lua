vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']d', function ()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', function ()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to prev [D]iagnostic message' })

