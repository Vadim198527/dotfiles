-- lua/mdlist.lua
local M = {}

-- helpers
local function trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

-- безопасная замена текущей строки (в insert делаем через schedule)
local function set_line_smart(new_line)
	local row = vim.api.nvim_win_get_cursor(0)[1]
	if vim.fn.mode():sub(1, 1) == "i" then
		vim.schedule(function()
			vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
			vim.api.nvim_win_set_cursor(0, { row, #new_line })
		end)
	else
		vim.api.nvim_set_current_line(new_line)
	end
end

-- parse list line
local function parse_list_line(line)
	local indent = line:match("^(%s*)") or ""
	local m, rest = line:match("^%s*([%-%*%+])%s+(.*)$")
	if m then
		local cb = rest:match("^%[([ xX])%]%s*")
		local has_cb = cb ~= nil
		local text = has_cb and rest:gsub("^%[[ xX]%]%s*", "") or rest
		return {
			kind = "bullet",
			indent = indent,
			marker = m,
			num = nil,
			has_cb = has_cb,
			cb_state = cb,
			text = text,
		}
	end
	local n, sep, rest2 = line:match("^%s*(%d+)([%.%)])%s+(.*)$")
	if n then
		local cb = rest2:match("^%[([ xX])%]%s*")
		local has_cb = cb ~= nil
		local text = has_cb and rest2:gsub("^%[[ xX]%]%s*", "") or rest2
		return {
			kind = "number",
			indent = indent,
			marker = sep,
			num = tonumber(n),
			has_cb = has_cb,
			cb_state = cb,
			text = text,
		}
	end
	return nil
end

-- parse header
local function parse_header(line)
	local indent, hashes, text = line:match("^(%s*)(#+)%s*(.*)$")
	if hashes then
		return { indent = indent or "", level = #hashes, text = text or "" }
	end
	return nil
end

-- features
function M.on_cr()
	local line = vim.api.nvim_get_current_line()
	local info = parse_list_line(line)
	if not info then
		return "\n"
	end

	-- пустой пункт -> убрать маркер и выйти из списка
	if trim(info.text) == "" then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local indent = info.indent
		vim.schedule(function()
			vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent })
			vim.api.nvim_win_set_cursor(0, { row, #indent })
		end)
		return "\n"
	end

	if info.kind == "bullet" then
		local cb = info.has_cb and "[ ] " or ""
		return "\n" .. info.indent .. info.marker .. " " .. cb
	else
		local nextn = (info.num or 1) + 1
		local cb = info.has_cb and "[ ] " or ""
		return "\n" .. info.indent .. tostring(nextn) .. info.marker .. " " .. cb
	end
end

function M.toggle_checkbox()
	local line = vim.api.nvim_get_current_line()
	local info = parse_list_line(line)
	if not info then
		return
	end

	if info.has_cb then
		local new = line:gsub("%[([ xX])%]", function(c)
			if c == " " then
				return "[x]"
			else
				return "[ ]"
			end
		end, 1)
		set_line_smart(new)
	else
		if info.kind == "bullet" then
			set_line_smart(("%s%s [ ] %s"):format(info.indent, info.marker, info.text))
		else
			set_line_smart(("%s%d%s [ ] %s"):format(info.indent, info.num, info.marker, info.text))
		end
	end
end

-- function M.make_task()
--   local line = vim.api.nvim_get_current_line()
--   local info = parse_list_line(line)
--   if not info or info.has_cb then return end
--   if info.kind == "bullet" then
--     set_line_smart(("%s%s [ ] %s"):format(info.indent, info.marker, info.text))
--   else
--     set_line_smart(("%s%d%s [ ] %s"):format(info.indent, info.num, info.marker, info.text))
--   end
-- end

function M.make_task()
	local line = vim.api.nvim_get_current_line()
	local info = parse_list_line(line)

	if info then
		-- уже список: добавляем чекбокс, если его нет
		if info.has_cb then
			return
		end
		if info.kind == "bullet" then
			set_line_smart(("%s%s [ ] %s"):format(info.indent, info.marker, info.text))
		else
			set_line_smart(("%s%d%s [ ] %s"):format(info.indent, info.num, info.marker, info.text))
		end
		return
	end

	-- не список: превращаем строку в bullet-задачу, сохраняя отступ
	local indent = line:match("^(%s*)") or ""
	local text = line:sub(#indent + 1)
	set_line_smart(("%s- [ ] %s"):format(indent, text))
end

function M.adjust_header(dir)
	local line = vim.api.nvim_get_current_line()
	local h = parse_header(line)
	if not h then
		return
	end
	local new_level = (dir == "right") and math.max(1, h.level - 1) or math.min(6, h.level + 1)
	set_line_smart(("%s%s %s"):format(h.indent, string.rep("#", new_level), h.text))
end

function M.ctrl(dir)
	local line = vim.api.nvim_get_current_line()
	local h = parse_header(line)
	if h then
		M.adjust_header(dir)
		return
	end
	local info = parse_list_line(line)
	if info then
		if info.has_cb then
			M.toggle_checkbox()
		else
			M.make_task()
		end
	end
end

function M.renumber_selection()
	-- границы визуального выделения
	local srow = vim.api.nvim_buf_get_mark(0, "<")[1]
	local erow = vim.api.nvim_buf_get_mark(0, ">")[1]
	if not srow or srow == 0 then
		vim.notify("Нет визуального выделения", vim.log.levels.WARN)
		return
	end
	if srow > erow then
		srow, erow = erow, srow
	end

	local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)

	-- базовый пункт = первый нумерованный в выделении
	local base
	for _, line in ipairs(lines) do
		local info = parse_list_line(line)
		if info and info.kind == "number" then
			base = info
			break
		end
	end
	if not base then
		vim.notify("В выделении нет нумерованных пунктов", vim.log.levels.WARN)
		return
	end

	local cur = base.num
	local new_lines = {}
	for _, line in ipairs(lines) do
		local info = parse_list_line(line)
		if info and info.kind == "number" and info.indent == base.indent and info.marker == base.marker then
			local cb = info.has_cb and ("[" .. (info.cb_state or " ") .. "] ") or ""
			table.insert(new_lines, string.format("%s%d%s %s%s", info.indent, cur, info.marker, cb, info.text))
			cur = cur + 1
		else
			table.insert(new_lines, line)
		end
	end

	vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, new_lines)
end

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "markdown", "md", "markdown.mdx" },
		callback = function()
			vim.keymap.set("i", "<CR>", function()
				return M.on_cr()
			end, { buffer = true, expr = true, desc = "Markdown: continue list item" })

			vim.keymap.set(
				"n",
				"<localleader>x",
				M.toggle_checkbox,
				{ buffer = true, desc = "Markdown: toggle checkbox" }
			)
			vim.keymap.set("n", "<localleader>X", M.make_task, { buffer = true, desc = "Markdown: make task checkbox" })

			vim.keymap.set({ "n", "i" }, "<C-S-h>", function()
				M.ctrl("right")
			end, { buffer = true, silent = true, desc = "MD: checkbox or header level ↓" })
			vim.keymap.set({ "n", "i" }, "<C-S-l>", function()
				M.ctrl("left")
			end, { buffer = true, silent = true, desc = "MD: checkbox or header level ↑" })
			-- Перенумеровать выделение
			vim.keymap.set("x", "<leader>n", function()
				M.renumber_selection()
			end, { buffer = true, silent = true, desc = "MD: renumber selected list" })
		end,
	})
end

return M
