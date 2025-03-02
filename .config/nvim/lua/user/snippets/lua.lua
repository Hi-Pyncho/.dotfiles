local ls = require 'luasnip'
local fmta = require('luasnip.extras.fmt').fmta

local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets('lua', {
  s(
    'lua-create-snippet',
    fmta(
      [[
      s('<>', fmta(<>))
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
})
