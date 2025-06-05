local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local sn = ls.snippet_node
local d = ls.dynamic_node
local f = ls.function_node
local events = require("luasnip.util.events")

return {
	s("lua", fmta(
        [[
        ```lua
        <>
        ```
        ]], {i(0)}
    )),
	s("sh", fmta(
        [[
        ```sh
        <>
        ```
        ]], {i(0)}
    )),
}
