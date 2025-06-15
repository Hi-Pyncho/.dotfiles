return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {},
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    input = {},
    notifier = {},
    scroll = {}
  },
  keys = {
    {
      '<leader>n',
      function ()
        if (Snacks) then
          Snacks.notifier.show_history();
        end
      end,
      desc = 'Show notifications history'
    }
  }
}
