local M = {}

-- ---@param iTable table
-- ---@param sep? string
-- ---@return string
-- function M.join (iTable, sep)
--   local res = ''
--   sep = sep or ''
--
--   for index, value in ipairs(iTable) do
--     if index < #iTable and index > 1 then
--       res = res..sep..value
--     else
--       res = res..value
--     end
--   end
--
--   return res
-- end

return M
