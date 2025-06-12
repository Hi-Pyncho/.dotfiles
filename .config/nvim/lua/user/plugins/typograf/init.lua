local getClipboardContent = require "user.nvimHelpers.getClipboardContent"

local M = {}

function M.setup(config)
  config = config or {}

  vim.keymap.set('n', '<leader>cv', function ()
    local clipboardContent = getClipboardContent()
    local cmdCommand = "read !echo '" .. clipboardContent .. "' | typograf -l ru --stdin --html-entity-type name"
    vim.cmd(cmdCommand)
  end, { desc = 'Typograf text from clipboard and paste' })

  vim.keymap.set('v', '<leader>ct', function ()
    vim.cmd("'<,'>!typograf -l ru --stdin --html-entity-type name")
  end, { desc = 'Typograf selected text' })
end

return M
