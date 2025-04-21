return {
  'nativerv/cyrillic.nvim',
  enabled = false,
  event = { 'VeryLazy' },
  config = function()
    require('cyrillic').setup {
      no_cyrillic_abbrev = false, -- default
    }
    vim.keymap.set('i', 'оо', '<Esc>', { desc = 'which_key_ignore' })
  end,
}
