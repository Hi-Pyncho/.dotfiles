-- git-conflicts
vim.keymap.set('n', '<leader>gco', '<Plug>(git-conflict-ours)', { desc = 'Git-conflict choose ours'})
vim.keymap.set('n', '<leader>gct', '<Plug>(git-conflict-theirs)', { desc = 'Git-conflict choose theirs'})
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { desc = 'Git-conflict choose both'})
vim.keymap.set('n', '<leader>gc0', '<Plug>(git-conflict-none)', { desc = 'Git-conflict choose none'})
vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Git-conflict prev'})
vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Git-conflict next'})

