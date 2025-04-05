vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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

vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostic
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to prev [D]iagnostic message' })

-- Marks
local delMarkOnCurLine = require 'user.functions.deleteMark'
vim.keymap.set('n', 'cm', delMarkOnCurLine, { desc = 'Remove mark on the current line' })

-- Buffer
vim.keymap.set('n', '<M-[>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer', silent = true })
vim.keymap.set('n', '<M-]>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<C-w>', function()
  Snacks.bufdelete()
end, { desc = 'Remove current buffer' })

-- Misc
vim.keymap.set('n', '<leader>cr', '<cmd>%s/console.log(.*)//g<cr>', { desc = 'Remove all log functions in the current file' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit', silent = true, noremap = true })
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>fx', '<cmd>:w<cr><cmd>:source %<cr>', { desc = 'Execute current file' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit from insert mode', silent = true, noremap = true })
vim.keymap.set('n', '<leader>fi', 'gg=G', { desc = 'Reindent whole file' })

-- Delete keymaps
vim.keymap.set('i', '<c-c>', function() end)

-- Flash
vim.keymap.set({ 'x', 'n', 'o' }, 'f', function()
  require('flash').jump()
end, { desc = 'Flash and jump to position' })

-- Terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Switch to normal mode' })

local job_id = 0
function openTerminal()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)

  job_id = vim.bo.channel
end
vim.keymap.set('n', '<c-/>', openTerminal, { desc = 'Terminal open' })
vim.keymap.set('n', '<c-_>', openTerminal, { desc = 'Terminal open' })

vim.keymap.set('n', '<leader>ww', function()
  vim.fn.chansend(job_id, { 'll', '' })
end)

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
