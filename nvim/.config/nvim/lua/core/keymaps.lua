function RunCode()
	-- Сохраняем текущий файл
	vim.cmd("w")
	-- Получаем тип файла
	local filetype = vim.bo.filetype

	-- Таблица соответствий типов файлов и команд для запуска
	local run_cmds = {
		python = "!python3 %",
		-- lua = "!lua %",
		lua = "luafile %",
		-- Вы можете добавить другие языки по необходимости
		javascript = "!node %",
		-- c = "botright 15split | terminal gcc -o a.out % && ./a.out",
	}

	-- Получаем команду для текущего типа файла
	local cmd = run_cmds[filetype]

	if cmd then
		-- Выполняем команду
		vim.cmd(cmd)
	else
		-- Выводим сообщение, если тип файла не поддерживается
		print("Невозможно выполнить этот тип файла: " .. filetype)
	end
end

local function olan()
	vim.cmd("write")
	local bufList = vim.api.nvim_list_bufs()
	for _, buf in ipairs(bufList) do
		local bufName = vim.api.nvim_buf_get_name(buf)
		if string.match(bufName, "^term://") ~= nil then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	-- vim.cmd("botright 15split | terminal gcc -o a.out % && ./a.out")
	vim.cmd(
		"silent !tmux send-keys -t .1 'clear && gcc -o a.out "
			.. vim.fn.expand("%")
			.. " && ./a.out' C-m && tmux select-pane -t .1"
	)
end
local keymap = vim.keymap.set

keymap("v", "<leader>dl", '"_d', { noremap = true, silent = true })
keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("n", "<leader>ch", ":AvanteClear<cr>", { noremap = true, silent = true })
keymap("n", "<F5>", function()
	vim.cmd("normal! zz")
	vim.cmd("normal! 7")
end, { noremap = true })
keymap("i", "<F5>", function()
	vim.cmd("normal! zz")
	vim.cmd("normal! 7")
end, { noremap = true })
keymap("n", "<C-p>", "o<Left><Right><Esc>", { noremap = true })
-- keymap("n", "<C-a>", "^", { noremap = true, silent = true })
keymap("n", "<C-a>", "0", { noremap = true, silent = true })
keymap({ "n", "o", "v" }, "<C-e>", "$", { noremap = true })
keymap("n", "<leader>w/", ":vsplit<CR>", { noremap = true })
keymap("n", "<leader>ww", ":wincmd w<CR>", { noremap = true, silent = true })
keymap("n", "<leader>w-", ":split<CR>", { noremap = true })
keymap("n", "<leader>wd", ":close<CR>", { noremap = true })
keymap("n", "<leader>x", ":close<CR>", { noremap = true })
keymap("n", "<leader>w1", ":only<CR>", { noremap = true })
keymap("i", "<C-a>", "<esc>I", { noremap = true })
keymap("i", "<C-e>", "<esc>A", { noremap = true })
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-e>", "<End>", { noremap = true })
keymap("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true })
keymap("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true })
keymap("v", "<D-c>", '"+y', { noremap = true, silent = true })
keymap("x", "y", "y`>", { silent = true })
keymap("n", "<C-.>", "<C-a>")
keymap("n", "<C-,>", "<C-x>")
keymap("n", "<leader>rc", ":lua RunCode()<CR>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		keymap("n", "<leader>rc", olan, { buffer = true })
	end,
})
-- Настройка сочетаний клавиш
keymap("n", "<C-Space>", ":lua toggle_keymap()<CR>", { noremap = true, silent = true })
keymap("i", "<C-Space>", "<C-o>:lua toggle_keymap()<CR>", { noremap = true, silent = true })
keymap("i", "<Plug>luasnip-expand-snippet", '<cmd>lua require("luasnip").expand()<CR>', { silent = true })
keymap("i", "<Plug>luasnip-jump-next", '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })
keymap("i", "<C-l>", "<Tab>", { noremap = true, silent = true })

-- Отмена последнего действия при нажатии Ctrl + / в режиме вставки
keymap("i", "<C-/>", "<C-o>u", { noremap = true, silent = true })

-- keymap("n", "<leader>h", ":nohlsearch<CR>")
-- resize window
keymap("n", "_", ":resize -1<CR>")
keymap("n", "+", ":resize +1<CR>")
keymap("n", "<leader>sv", ":w<CR>:source %<CR>")
keymap("v", "<leader>sv", ":<c-u>w<CR>:source %<CR>")
keymap("i", "<C-b>", "<Left>", { noremap = true, desc = "Move cursor left in insert mode" })
keymap("c", "<C-b>", "<Left>", { noremap = true, desc = "Move cursor left in insert mode" })
keymap("i", "<C-f>", "<Right>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("c", "<C-f>", "<Right>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("c", "<C-g>", "<C-f>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("i", "<C-CR>", "<esc>o", { noremap = true })
keymap("i", "<C-j>", "<esc>o", { noremap = true })
keymap("i", "<C-d>", "<esc>lxi", { noremap = true })
keymap("c", "<C-d>", "<esc>lxi", { noremap = true })

vim.keymap.set("i", "<C-k>", function()
	local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
	vim.api.nvim_feedkeys(keys, "t", true)
end, { noremap = true })

-- keymap("n", "<leader>ni", ":Neorg index<CR>", { desc = "Move cursor right in insert mode" })
keymap("n", "<leader>R", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relativenumber" })
keymap("n", "<leader>N", function()
	vim.o.number = not vim.o.number
end, { desc = "Toggle number" })
keymap("n", "<leader>mf", function()
	MiniFiles.open()
end, { desc = "Open Mini.files" })
-- keymap("n", "<leader>sa", "ggVG", { desc = "Select All" })
local function select_all()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	local cur_line = cur_pos[1]
	local last_line = vim.fn.line("$")

	if cur_line > 1 then
		-- Not at top, jump to top to add current to jumplist
		vim.cmd("normal! gg")
		-- Now at top, start visual
		vim.cmd("normal! V")
		-- Extend to bottom without adding to jumplist
		vim.cmd("keepjumps normal! G")
	else
		-- At top (or single line)
		if last_line > 1 then
			-- Jump to bottom to add current (top) to jumplist
			vim.cmd("normal! G")
			-- Now at bottom, move back to top without adding
			vim.cmd("keepjumps normal! gg")
			-- Now at top, start visual
			vim.cmd("normal! V")
			-- Extend to bottom without adding
			vim.cmd("keepjumps normal! G")
		else
			-- Single line buffer
			vim.cmd("normal! V")
		end
	end
end

keymap("n", "<leader>sa", select_all, { desc = "Select All" })
keymap("n", "<leader>cp", ":%y+<CR>", { desc = "Yank All" })
keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.cmd([[
nnoremap <leader>F :call FoldColumnd()<CR>

function! FoldColumnd()
    if &foldcolumn
        let &foldcolumn = 0
    else
        let &foldcolumn = 4
    endif
endfunction
]])

vim.cmd([[
nnoremap <leader>q :call QuickFixToggle()<cr>

let g:quickfixisopen = 0
function! QuickFixToggle()
    if g:quickfixisopen
        cclose
        let g:quickfixisopen = 0
    else
        copen
        let g:quickfixisopen = 1
    endif
endfunction
]])

-- базовые пары
local base = {
  a = "á", A = "Á",
  e = "é", E = "É",
  i = "í", I = "Í",
  o = "ó", O = "Ó",
  u = "ú", U = "Ú",
  n = "ñ", N = "Ñ",
}

-- таблица для переключения в обе стороны
local toggle = vim.deepcopy(base)
for k, v in pairs(base) do
  toggle[v] = k
end

vim.keymap.set("i", "<C-'>", function()
  -- позиция курсора в символах (а не байтах)
  local cc = vim.fn.charcol(".")  -- 1-based
  if cc <= 1 then
    return ""
  end

  local line = vim.api.nvim_get_current_line()
  -- предыдущий символ (0-based индекс для strcharpart)
  local prev = vim.fn.strcharpart(line, cc - 2, 1)

  local new_char = toggle[prev]
  if new_char then
    return "<BS>" .. new_char
  end
  return ""
end, { expr = true })
