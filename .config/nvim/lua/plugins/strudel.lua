return {
  "gruvw/strudel.nvim",
  cmd = "StrudelLaunch",
  build = "npm install",
  config = function()
    require("strudel").setup()
    vim.keymap.set('n', '<leader>ml', '<cmd>StrudelLaunch<CR>', { desc = 'strudel launch '})
    vim.keymap.set('n', '<leader>mt', '<cmd>StrudelToggle<CR>', { desc = 'strudel toggle '})
    vim.keymap.set('n', '<leader>mu', '<cmd>StrudelUpdate<CR>', { desc = 'strudel update '})
  end,
}
