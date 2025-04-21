return {
  dir = '~/.config/nvim/lua/user/plugins/typograf',
  name = 'typograf',
  event = { 'VeryLazy' },
  config = function ()
    if vim.fn.executable("typograf") == 0 then
      vim.notify("typograf-cli не установлен! Используйте: pnpm add -g typograf-cli", vim.log.levels.WARN)
    end
    require('user.plugins.typograf').setup({})
  end
}
