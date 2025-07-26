local M = {}

function M.getSelectedText()
  -- Save the current register contents
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')

  -- Yank the selected text to the unnamed register
  vim.cmd('silent normal! y')

  -- Get the yanked text
  local selected_text = vim.fn.getreg('"')

  -- Restore the register contents
  vim.fn.setreg('"', saved_reg, saved_regtype)

  return selected_text
end

return M
