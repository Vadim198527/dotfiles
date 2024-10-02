local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local sn = ls.snippet_node
local d = ls.dynamic_node
local f = ls.function_node

local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end
-- ----------------------------------------------------------------------------
return {
    s({ trig = "itm" }, { t("\\item ") }, {
        condition = function()
            return not in_mathzone()
        end,
    }),
    -- s({ trig = "(", snippetType = "autosnippet" }, fmta("(<>)", { d(1, get_visual) })),
    s({ trig = "tii", snippetType = "autosnippet" }, fmta("\\textit{<>}", { d(1, get_visual) })),
    s(
        { trig = "([%a])", regTrig = true },
        fmta([[$\mathrm{<>}$ ]], {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = ";([%u])", snippetType = "autosnippet", regTrig = true },
        fmta("$\\mathcal{<>}$ ", { f(function(_, snip)
            return snip.captures[1]
        end) }),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    -- \setcounter
    s(
        { trig = "setc", regTrig = true },
        fmta("\\setcounter{<>}{<>}", {i(1), i(2)}),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
}
