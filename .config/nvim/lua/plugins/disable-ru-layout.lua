return {
  dir = '~/.config/nvim/lua/user/plugins/disable-ru-layout',
  name = 'disable-ru-layout',
  event = { 'VeryLazy' },
  config = function ()
    require('user.plugins.disable-ru-layout').setup({})
  end
}
