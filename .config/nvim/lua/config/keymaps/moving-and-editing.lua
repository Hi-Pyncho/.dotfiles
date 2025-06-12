--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- move lines
vim.keymap.set('i', '<M-j>', '<Esc><Cmd>m .+1<CR>==gi')
vim.keymap.set('n', '<M-j>', '<Cmd>execute "move .+" . v:count1<CR>==')
vim.keymap.set('v', '<M-j>', [[:<C-U>execute "'<lt>,'>move '>+" . v:count1<CR>gv=gv]])

vim.keymap.set('i', '<M-k>', '<Esc><Cmd>m .-2<CR>==gi')
vim.keymap.set('n', '<M-k>', [[<Cmd>execute "move .-" . (v:count1 + 1)<CR>==]])
vim.keymap.set('v', '<M-k>', [[:<C-U>execute "'<lt>,'>move '<lt>-" . (v:count1 + 1)<CR>gv=gv]])

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Flash
vim.keymap.set({ 'x', 'n', 'o' }, 'f', function()
  require('flash').jump()
end, { desc = 'Flash and jump to position' })
