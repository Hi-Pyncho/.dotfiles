vim.keymap.set('n', '<leader>cr', '<cmd>%s/console.log(.*)//g<cr>',
{ desc = 'Remove all log functions in the current file' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit', silent = true, noremap = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit from insert mode', silent = true, noremap = true })

-- Delete keymaps
vim.keymap.set('i', '<c-c>', function() end)
