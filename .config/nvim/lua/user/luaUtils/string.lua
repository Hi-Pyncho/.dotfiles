local M = {}

---@param str string
---@param sep string
---@return table
function M.split(str, sep)
  local parts = {}

  for part in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(parts, part)
  end

  return parts
end

---@param input string The original string
---@param oldStr string The substring to replace
---@param newStr string The replacement substring
---@return string
function M.replace(input, oldStr, newStr)
  local result = input
  result = result:gsub(oldStr, newStr)

  return result
end

---@param input string
---@param replacements table Table of {[old]=new} pairs
---@return string
function M.replaceMultiple(input, replacements)
    local result = input

    for old_str, new_str in pairs(replacements) do
        result = result:gsub(old_str, new_str)
    end

    return result
end
-- Usage:
-- local text = "The quick brown fox"
-- local replacements = {
--     ["quick"] = "slow",
--     ["brown"] = "red",
--     ["fox"] = "dinosaur"
-- }

return M
