local ls = require("luasnip")
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets("scss", {
  snip({
    trig = "test",
    namr = "TEST",
    dscr = "sdfsdfsdf",
  }, {
    text("ssssssssssssssssssss"),
  }),
})

ls.filetype_extend("css", { "scss" })
