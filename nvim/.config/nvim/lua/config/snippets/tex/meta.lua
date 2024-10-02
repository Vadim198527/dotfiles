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
	s({ trig = "pac", dscr = "Package" }, fmta("\\usepackage[<>]{<>}<>", { i(1), i(2), i(3) })),
	s({ trig = "sec", dscr = "Section" }, fmta("\\section{<>}<>", { i(1), i(2) })),
	s({ trig = "ssec", dscr = "Subsection" }, fmta("\\subsection{<>}<>", { i(1), i(2) })),
}
