return {
  dir = '~/.config/nvim/lua/user/plugins/floaterminal',
  name = 'floaterminal',
  event = { 'VeryLazy' },
  config = function ()
    require('user.plugins.floaterminal').setup({})
  end
}
