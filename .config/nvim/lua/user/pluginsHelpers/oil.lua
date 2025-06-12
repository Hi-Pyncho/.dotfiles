local M = {}

function M.getFolderPathUnderCursor()
  local oil = require('oil')
  local curBuf = vim.api.nvim_get_current_buf()
  return oil.get_current_dir(curBuf)
end

function M.getFilePathUnderCursor()
  local oil = require('oil')
  local entry = oil.get_cursor_entry()
  local dirPath = M.getFolderPathUnderCursor()

  if entry and dirPath then
    return dirPath..entry.parsed_name
  end

  return nil
end

return M
