return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'
    require('lualine').setup {
      options = {
        theme = 'tokyonight'
      },
      on_colors = function(colors)
        P(colors)
        -- colors.hint = colors.orange
        -- colors.error = "#ff0000"
      end
    }
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
