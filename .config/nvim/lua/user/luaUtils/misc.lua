local M = {}

function M.uniqueId()
  return os.time() .. math.random(1, 10000)
end

return M
