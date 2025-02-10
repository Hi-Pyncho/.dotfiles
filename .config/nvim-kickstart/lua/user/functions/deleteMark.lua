local function delMarkOnCurrentLine()
  local curBuf = vim.api.nvim_get_current_buf()
  local curWin = vim.api.nvim_get_current_win()
  local cursorPos = vim.api.nvim_win_get_cursor(curWin)

  local function delMark(charNum, buf)
    local mark = vim.fn.nr2char(charNum)
    local markLine = vim.api.nvim_buf_get_mark(buf, mark)[1]

    if markLine == cursorPos[1] then
      vim.api.nvim_buf_del_mark(buf, mark)
      return true
    end

    return false
  end

  local deleted = false

  for i = 97, 122 do
    local res = delMark(i, curBuf)

    if res then
      deleted = true
      break
    end
  end

  if deleted then
    return
  end

  for i = 65, 90 do
    delMark(i, curBuf)
  end
end

return delMarkOnCurrentLine
