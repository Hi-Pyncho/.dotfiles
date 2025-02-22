-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('i', '<M-j>', '<Esc><Cmd>m .+1<CR>==gi')
vim.keymap.set('n', '<M-j>', '<Cmd>execute "move .+" . v:count1<CR>==')
vim.keymap.set('v', '<M-j>', [[:<C-U>execute "'<lt>,'>move '>+" . v:count1<CR>gv=gv]])

vim.keymap.set('i', '<M-k>', '<Esc><Cmd>m .-2<CR>==gi')
vim.keymap.set('n', '<M-k>', [[<Cmd>execute "move .-" . (v:count1 + 1)<CR>==]])
vim.keymap.set('v', '<M-k>', [[:<C-U>execute "'<lt>,'>move '<lt>-" . (v:count1 + 1)<CR>gv=gv]])

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostic
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to prev [D]iagnostic message' })

-- Marks
local delMarkOnCurLine = require 'user.functions.deleteMark'
vim.keymap.set('n', 'dm', delMarkOnCurLine, { desc = 'Remove mark on the current line' })

-- Buffer
vim.keymap.set('n', '<M-[>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer', silent = true })
vim.keymap.set('n', '<M-]>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<C-w>', function()
  Snacks.bufdelete()
end, { desc = 'Remove current buffer' })

-- Misc
vim.keymap.set('n', '<leader>rc', '<cmd>%s/console.log(.*)//g<cr>', { desc = 'Remove all log functions in the current file' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit', silent = true, noremap = true })
vim.keymap.set({ 'n', 'i' }, '<c-s>', '<cmd>w<CR><Esc>', { desc = 'Save file', silent = true, noremap = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader><leader>x', '<cmd>:w<cr><cmd>:source %<cr>', { desc = 'Execute current file' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit from insert mode', silent = true, noremap = true })

-- Delete keymaps
vim.keymap.set('i', '<c-c>', function() end)

-- Flash
vim.keymap.set({ 'x', 'n', 'o' }, 'f', function()
  require('flash').jump()
end, { desc = 'Flash and jump to position' })
