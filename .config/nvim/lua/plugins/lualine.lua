local gitUtils = require('user.luaUtils.git')

return {
  -- enabled = false,
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local function currentPath()
      return gitUtils.getRelativePath() or ''
    end

    require('lualine').setup({
      sections = {
        lualine_a = {
          'mode'
        },
        lualine_b = {
          'branch',
        },
        lualine_c = {
          currentPath
        },
        lualine_x = {
          'filesize',
          'filetype',
        },
      }
    })
  end
}
