-- ~/.config/nvim/lua/pretty_math.lua
local M = {}
local ns = vim.api.nvim_create_namespace("pretty_math")

----------------------------------------------------------------------
-- 1. Таблица «LaTeX‑команда → глиф»
----------------------------------------------------------------------
local pretties = {
	["\\in"] = "∈",
	["\\forall"] = "∀",
	["\\exists"] = "∃",
	["\\subseteq"] = "⊆",
	["\\subset"] = "⊂",
	["\\supseteq"] = "⊇",
	["\\supset"] = "⊃",
	["\\to"] = "→",
}

-- Добавляем A…Z для \mathrm{<буква>}
do
	for code = 65, 90 do
		local ch = string.char(code)
		pretties["\\mathrm{" .. ch .. "}"] = ch
	end
end

do
	for code = 65, 90 do
		local ch = string.char(code)
		pretties["\\mathcal{" .. ch .. "}"] = ch
	end
end

----------------------------------------------------------------------
-- 2. Отрисовка conceal‑extmark'ов (без изменений)
----------------------------------------------------------------------
local function clear(buf)
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
end

local function apply(buf, topline, botline)
	local lines = vim.api.nvim_buf_get_lines(buf, topline, botline + 1, false)
	for i, line in ipairs(lines) do
		local lnum = topline + i - 1
		for pat, glyph in pairs(pretties) do
			local s, e = line:find(pat)
			while s do
				vim.api.nvim_buf_set_extmark(buf, ns, lnum, s - 1, {
					end_col = e,
					conceal = glyph, -- ⟵⟵⟵ главное отличие
					hl_group = "Conceal",
				})
				s, e = line:find(pat, e + 1)
			end
		end
	end
end

function M.refresh()
	local buf = vim.api.nvim_get_current_buf()
	clear(buf)
	apply(buf, vim.fn.line("w0") - 1, vim.fn.line("w$") - 1)
end

----------------------------------------------------------------------
--  SKIP‑MOVE  (два нажатия на любую скрытую команду)
----------------------------------------------------------------------
local function ext_at(buf, row, col, dir)
	local mark = nil
	if dir == 1 then
		local marks = vim.api.nvim_buf_get_extmarks(buf, ns, { row, col }, { row, -1 }, { details = true })
		mark = marks[1]
	else
		local marks = vim.api.nvim_buf_get_extmarks(buf, ns, { row, 0 }, { row, col }, { details = true })
		-- vim.print(marks)
		mark = marks[#marks]
	end
	return mark
end

local function skip_conceal(dir, count)
	count = count or 1
	local buf = vim.api.nvim_get_current_buf()

	for _ = 1, count do
		local row1, col = unpack(vim.api.nvim_win_get_cursor(0)) -- 1‑based
		local row0 = row1 - 1 -- 0‑based
		local ext = ext_at(buf, row0, col, dir)
		local s = -1
		local e = -1
		if ext then
			s = ext[3]
			e = ext[4].end_col
			-- vim.print(s, e)
		end

		if dir > 0 then ----------------------------------------- ►  l
			-- (1) следующая ячейка — начало скрытой области?
			-- if ext_at(buf, row0, col + 1) then
			if ext and col + 1 == s then
				vim.api.nvim_win_set_cursor(0, { row1, col + 1 }) -- зашли «на» глиф
			else
				-- local ext = ext_at(buf, row0, col) -- (2) мы внутри?
				if ext and col >= s and col <= e then
					vim.api.nvim_win_set_cursor(0, { row1, e }) -- выскочили
				else
					vim.cmd.normal({ "l", bang = true }) -- обычный шаг
				end
			end
		else ------------------------------------ ◄  h
			if ext and col - 1 == e then
				-- if col > 0 and ext_at(buf, row0, col) then
				vim.api.nvim_win_set_cursor(0, { row1, col - 1 }) -- зашли «на» глиф
			else
				-- local ext = ext_at(buf, row0, col - 1) -- (2) мы внутри?
				if ext and col > s and col <= e then
					vim.api.nvim_win_set_cursor(0, { row1, s }) -- вышли перед
				else
					vim.cmd.normal({ "h", bang = true }) -- обычный шаг
				end
			end
		end
	end
end
----------------------------------------------------------------------
-- 4. Подключаемся к буферу + ставим key‑maps
----------------------------------------------------------------------
function M.attach()
	if vim.b.pretty_math_attached then
		return
	end
	vim.b.pretty_math_attached = true

	vim.api.nvim_create_autocmd(
		{ "BufEnter", "TextChanged", "TextChangedI", "WinScrolled" },
		{ group = vim.api.nvim_create_augroup("PrettyMath", { clear = false }), buffer = 0, callback = M.refresh }
	)

	-- ⟪ h / l ⟫ в Normal‑mode
	local opts = { buffer = 0, silent = true }
	vim.keymap.set("n", "l", function()
		skip_conceal(1, vim.v.count1)
	end, opts)
	vim.keymap.set("n", "h", function()
		skip_conceal(-1, vim.v.count1)
	end, opts)

	M.refresh()
end

return M
