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
	-- s({ trig = "s=" }, fmta("string=? <>", { i(1) })),
	-- s({ trig = "em" }, fmta("empty? ", {})),
	s({ trig = "def" }, fmta("(define <>)", {i(1)})),
	s({ trig = "deff" }, fmta("(define (<>) <>)", {i(1), i(0)})),
	s({ trig = "con" }, fmta("(cond (<>))", {i(1)})),
	-- s({ trig = "che" }, fmta("(check-expect (<>) <>)", {i(1), i(2)})),
	-- s({ trig = "fi" }, fmta("first ", {})),
	-- s({ trig = "re" }, fmta("rest ", {})),
}
