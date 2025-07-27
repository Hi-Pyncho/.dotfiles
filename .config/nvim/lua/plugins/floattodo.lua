return {
  dir = '~/.config/nvim/lua/user/plugins/floattodo/',
  name = 'floattodo',
  event = { 'VeryLazy' },
  config = function ()
    require('user.plugins.floattodo').setup({})
    vim.keymap.set('n', '<leader>td', '<cmd>TodoToggle<CR>', { desc = 'Open todo file' })
  end
}
