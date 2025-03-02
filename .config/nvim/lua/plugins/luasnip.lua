return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saghen/blink.cmp',
    -- 'rafamadriz/friendly-snippets',
  },
  config = function()
    require('luasnip.loaders.from_vscode').load { paths = './snippets' }
    require 'user.snippets'

    local ls = require 'luasnip'

    vim.keymap.set({ 'i', 's' }, '<C-L>', function()
      ls.jump(1)
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-H>', function()
      ls.jump(-1)
    end, { silent = true })
  end,
}
