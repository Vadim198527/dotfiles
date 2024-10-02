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
    s({ trig = "[", snippetType = "autosnippet" }, fmta("[<>]", { d(1, get_visual) }), { condition = in_mathzone }),
    s(
        { trig = "==", dscr = "equals", snippetType = "autosnippet" },
        fmta("&= <>", { i(1) }),
        { condition = in_mathzone }
    ),
    s(
        { trig = ";([%a])", snippetType = "autosnippet", regTrig = true },
        fmta("\\mathcal{<>}", { f(function(_, snip)
            return snip.captures[1]
        end) }),
        {
            condition = function()
                return in_mathzone()
            end,
        }
    ),
    -- powver set
    s({ trig = "ps" }, fmta("\\mathscr{R} (<>)", { d(1, get_visual) }), {
        condition = function()
            return in_mathzone()
        end,
    }),
    s({ trig = "neq", snippetType = "autosnippet" }, { t("\\neq ") }, {
        condition = in_mathzone,
    }),
    s({ trig = "_", snippetType = "autosnippet", wordTrig = false }, fmta("_{<>} ", { i(1) }), {
        condition = in_mathzone,
    }),
    s({ trig = "||", snippetType = "autosnippet" }, { t("\\mid ") }, {
        condition = in_mathzone,
    }),
    -- Арифметические
    s({ trig = "mod", snippetType = "autosnippet" }, fmta("\\pmod{<>} ", { d(1, get_visual) }), {
        condition = function()
            return in_mathzone()
        end,
    }),
    s({trig = "**", snippetType = "autosnippet"}, {t("\\cdot ")}, {
        condition = function()
            return in_mathzone()
        end,
    }),
    

    -- Логические операции
    s({ trig = "iff", snippetType = "autosnippet" }, { t("\\iff ") }, {
        condition = in_mathzone,
    }),
    s({ trig = "<>", snippetType = "autosnippet" }, { t("\\leftrightarrow ") }, {
        condition = in_mathzone,
    }),
    s({ trig = "->", snippetType = "autosnippet" }, { t("\\to ") }, {
        condition = function()
            return in_mathzone()
        end,
    }),
    s({ trig = "AA", snippetType = "autosnippet" }, { t("\\forall ") }, { condition = in_mathzone }),
    s({ trig = "EE", snippetType = "autosnippet" }, { t("\\exists ") }, { condition = in_mathzone }),
    s({ trig = "or", snippetType = "autosnippet" }, { t("\\lor ") }, { condition = in_mathzone }),
    s({ trig = "and", snippetType = "autosnippet" }, { t("\\land ") }, { condition = in_mathzone }),
    s({ trig = "eq", snippetType = "autosnippet" }, { t("\\equiv ") }, { condition = in_mathzone }),

    -- Операции над множествами
    s({ trig = "RR", snippetType = "autosnippet" }, { t("\\mathbb{R} ") }, { condition = in_mathzone }),
    s({ trig = "ZZ", snippetType = "autosnippet" }, { t("\\mathbb{Z} ") }, { condition = in_mathzone }),
    s({ trig = "inn", snippetType = "autosnippet" }, { t("\\in ") }, { condition = in_mathzone }),
    s({ trig = "cc", snippetType = "autosnippet" }, { t("\\subseteq ") }, {
        condition = in_mathzone,
    }),
    s({ trig = "nn", snippetType = "autosnippet" }, { t("\\cap") }, {
        condition = in_mathzone,
    }),
    s({ trig = "00", snippetType = "autosnippet" }, { t("\\varnothing") }, {
        condition = in_mathzone,
    }),
    s({ trig = "uu", snippetType = "autosnippet" }, { t("\\cup") }, {
        condition = in_mathzone,
    }),
    s({ trig = "UU", snippetType = "autosnippet" }, { t("\\bigcup") }, {
        condition = in_mathzone,
    }),

    s({ trig = "set", snippetType = "autosnippet" }, fmta("\\{ <> \\}", { d(1, get_visual) }), {
        condition = in_mathzone,
    }),

    s({ trig = "xx", snippetType = "autosnippet" }, { t("\\times ") }, {
        condition = in_mathzone,
    }),

    -- Other operations
    s({ trig = "tt", snippetType = "autosnippet" }, fmta("\\text{<>} ", { d(1, get_visual) }), {
        condition = in_mathzone,
    }),
}
