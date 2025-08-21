return {
  'ibhagwan/fzf-lua',
  config = function()
    require('fzf-lua').setup({
      lsp = {
        jump1 = true
      }
    })
  end
}
