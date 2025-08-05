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
    s({ trig = "pr" }, fmta("print(<>)", { i(1) })),
    s({ trig = "re" }, fmta("return ", {})),
    s(
        { trig = "if" },
        fmta(
            [[
                if <>:
                    <>
                else:
                    <>
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "forr" },
        fmta(
            [[
                for <> in range(<>):
                    <>
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "for" },
        fmta(
            [[
                for <> in <>:
                    <>
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "fn" },
        fmta(
            [[
                def <>(<>):
                    <>
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "fo" },
        fmta(
            [[
                file = open("<>")
            ]],
            { i(1) }
        )
    ),
}
