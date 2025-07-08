local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'kickstart-highlight-yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('WinNew', {
  desc = 'Wrap context in windows',
  group = augroup 'kickstart-wrap-win',
  command = 'windo set wrap',
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'kickstart-term-open',
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.number = false
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(args)
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if line_count > 10000 then
      vim.notify("Большой файл (" .. line_count .. " строк), отключаю плагины...", vim.log.levels.WARN)
      vim.bo[args.buf].swapfile = false
      vim.bo[args.buf].undofile = false
      vim.bo[args.buf].syntax = 'off'
      vim.bo[args.buf].filetype = 'off'
      vim.treesitter.stop()
      vim.opt.lazyredraw = true  -- отключает перерисовку экрана
      vim.opt.foldmethod = "manual"  -- отключает автоматическое фолдинг
    end
  end,
})
