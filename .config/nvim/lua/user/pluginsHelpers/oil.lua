local M = {}

function M.getFolderPathUnderCursor()
  local oil = require('oil')
  local curBuf = vim.api.nvim_get_current_buf()
  return oil.get_current_dir(curBuf)
end

function M.getFilenameUnderCursor()
  local oil = require('oil')
  local entry = oil.get_cursor_entry()

  if entry then
    return entry.parsed_name
  end
end

function M.getFilePathUnderCursor()
  local filename = M.getFilenameUnderCursor()
  local dirPath = M.getFolderPathUnderCursor()

  if filename and dirPath then
    return dirPath..filename
  end

  return nil
end

return M
