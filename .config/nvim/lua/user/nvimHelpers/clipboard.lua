local M = {}

function M.get()
  return vim.fn.getreg('+')
end

---@param str string
function M.set(str)
  vim.fn.setreg('+', str)
end

return M
