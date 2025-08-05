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


local ts_utils = require("nvim-treesitter.ts_utils")

local MATH_NODES = {
  inline_formula     = true,  -- $…$, \( … \)
  displayed_equation = true,  -- \[ … \]
  math_environment   = true,  -- \begin{align} … \end{align}, etc.
}

local function in_mathzone()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end
-- -------------------------------
return {
    s({ trig = "mk", snippetType = "autosnippet" }, fmta("$ <> $ ", { i(1) }), {
        condition = function()
            return not in_mathzone()
        end,
    }),

    s(
        { trig = "dm", snippetType = "autosnippet" },
        fmta(
            [[
	           \[
	           <>
	           \]
	           <>
	       ]],
            { i(1), i(2) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "beg", dscr = "begin environment" },
        fmta(
            [[
	               \begin{<>}
	                   <>
	               \end{<>}
	           ]],
            { i(1), i(2), rep(1) }
        )
    ),
    s(
        { trig = "ali", dscr = "Alignment" },
        fmta(
            [[
	               \begin{align}
	                   <>
	               \end{align}
	           ]],
            { i(1) }
        )
    ),
    s(
        { trig = "def", dscr = "definition" },
        fmta(
            [[
	               \begin{definition}
	                   <>
	               \end{definition}
	           ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "enum", dscr = "enumerate" },
        fmta(
            [[
                \begin{enumerate}
                    \item <>
                \end{enumerate}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "thm", dscr = "theorem" },
        fmta(
            [[
                \begin{theorem}
                    <>
                \end{theorem}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "lem", dscr = "lemma" },
        fmta(
            [[
                \begin{lemma}
                    <>
                \end{lemma}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "prf", dscr = "proof" },
        fmta(
            [[
                \begin{proof}
                    <>
                \end{proof}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "equ", dscr = "equation" },
        fmta(
            [[
                \begin{equation}
                    <>
                \end{equation}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return not in_mathzone()
            end,
        }
    ),
    s(
        { trig = "cas", dscr = "cases" },
        fmta(
            [[
                \begin{cases}
                    <>
                \end{cases}
            ]],
            { i(1) }
        ),
        {
            condition = function()
                return in_mathzone()
            end,
        }
    ),
}
