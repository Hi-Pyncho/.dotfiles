local ls = require 'luasnip'
local fmta = require('luasnip.extras.fmt').fmta

local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.filetype_extend('vue', { 'html' })
ls.filetype_extend('vue', { 'javascript' })

-- ls.add_snippets('vue', {
--   s('vue-import', fmta([[import { <> } from 'vue';]], { i(1) })),
-- })
