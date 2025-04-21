local fs = require('user.luaUtils.fs')
local s = require('user.luaUtils.string')

-- createFile( { content = 'fff\n2222\n3333', filePath = vim.fn.getcwd() .. '/text.txt'} )
-- P(fs.readFile({ filePath = vim.fn.getcwd() .. '/text.txt'}))
-- fs.fileExists(vim.fn.getcwd()..'/test/test.txt')
--
local ar = { "fff", "2222", "3333" }

local res = table.concat(ar, '-')
--
-- local res = t.join(ar, '\n')
--
P(res)
