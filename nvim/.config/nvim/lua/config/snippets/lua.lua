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
    s({ trig = "l" }, fmta("local ", {})),
    s(
        { trig = "fu" },
        fmta(
            [[
    function <>(<>)
        <>
    end
    ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "lfu" },
        fmta(
            [[
    local function <>(<>)
        <>
    end
    ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        { trig = "if" },
        fmta(
            [[
    if <> then
        <>
    end
    ]],
            { i(1), i(2) }
        )
    ),
    s(
        { trig = "for" },
        fmta(
            [[
    for <> do
        <>
    end
    ]],
            { i(1), i(2) }
        )
    ),
    s(
        { trig = "fip" },
        fmta(
            [[
    for <>, <> in ipairs(<>) do
        <>
    end
    ]],
            { i(1), i(2), i(3), i(0) }
        )
    ),
    s(
        { trig = "wh" },
        fmta(
            [[
    while <> do
        <>
    end
    ]],
            { i(1), i(2) }
        )
    ),
    s(
        { trig = "rep" },
        fmta(
            [[
    repeat
        <>
    until <>
    ]],
            { i(1), i(2) }
        )
    ),
    s(
        { trig = "fm" },
        fmta(
            [[
    string.format("<>", <>)
    ]],
            { i(1), i(2) }
        )
    ),
    s({ trig = "re" }, fmta("return ", {})),
    s(
        { trig = "con" },
        fmta(
            [[
            config = function()
                <>
            end
            ]],
            { i(1) }
        )
    ),

    s(
        { trig = "vin" },
        fmta(
            [[
            vim.inspect(<>)
            ]],
            { i(0) }
        )
    ),

    s(
        { trig = "vp" },
        fmta(
            [[
            vim.print(<>)
            ]],
            { i(0) }
        )
    ),
    
    s(
        { trig = "va" },
        fmta(
            [[
            vim.api.<>
            ]],
            { i(0) }
        )
    ),
}
