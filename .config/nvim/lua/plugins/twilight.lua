return {
  'folke/twilight.nvim',
  event = 'VeryLazy',
  config = function ()
    vim.keymap.set('n', '<leader>ct', '<cmd>Twilight<CR>', { desc = 'Toggle Twilight'} )
  end
}
