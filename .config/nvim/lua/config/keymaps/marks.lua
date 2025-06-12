local delMarkOnCurLine = require 'user.functions.deleteMark'

vim.keymap.set('n', '<leader>cm', delMarkOnCurLine, { desc = 'Remove mark on the current line' })
