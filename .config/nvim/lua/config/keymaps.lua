local delMarkOnCurLine = require 'user.functions.deleteMark'
local stringUtils = require('user.luaUtils.string')
local reindent = require 'user.functions.reindent'

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
vim.keymap.set('n', ']d', function ()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', function ()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to prev [D]iagnostic message' })

-- Marks
vim.keymap.set('n', '<leader>cm', delMarkOnCurLine, { desc = 'Remove mark on the current line' })

-- Buffer
vim.keymap.set('n', '<M-[>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer', silent = true })
vim.keymap.set('n', '<M-]>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<C-w>', function()
  Snacks.bufdelete()
end, { desc = 'Remove current buffer' })

-- Misc
vim.keymap.set('n', '<leader>cr', '<cmd>%s/console.log(.*)//g<cr>',
{ desc = 'Remove all log functions in the current file' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit', silent = true, noremap = true })
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>fx', '<cmd>:w<cr><cmd>:source %<cr>', { desc = 'Execute current file' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit from insert mode', silent = true, noremap = true })
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

-- Delete keymaps
vim.keymap.set('i', '<c-c>', function() end)

-- Flash
vim.keymap.set({ 'x', 'n', 'o' }, 'f', function()
  require('flash').jump()
end, { desc = 'Flash and jump to position' })

-- Terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Switch to normal mode' })

local job_id = 0
local function openTerminal()
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

-- oil helper
vim.keymap.set('n', '<leader>fd', function()
  local oil = require('oil')
  local curBuf = vim.api.nvim_get_current_buf()
  local dir = oil.get_current_dir(curBuf)

  vim.fn.setreg('+', dir)
end, { desc = 'Copy current dir path to clipboard' })

vim.keymap.set('n', '<leader>fs', function()
  local oil = require('oil')
  local curBuf = vim.api.nvim_get_current_buf()
  local dir = oil.get_current_dir(curBuf)
  local entry = oil.get_cursor_entry()

  if entry then
    vim.system({ 'du', '-sh', dir .. entry.parsed_name }, { text = true }, function(obj)
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

-- git-conflicts
vim.keymap.set('n', '<leader>gco', '<Plug>(git-conflict-ours)', { desc = 'Git-conflict choose ours'})
vim.keymap.set('n', '<leader>gct', '<Plug>(git-conflict-theirs)', { desc = 'Git-conflict choose theirs'})
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { desc = 'Git-conflict choose both'})
vim.keymap.set('n', '<leader>gc0', '<Plug>(git-conflict-none)', { desc = 'Git-conflict choose none'})
vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Git-conflict prev'})
vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Git-conflict next'})
