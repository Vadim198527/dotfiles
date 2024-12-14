local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.timeout = true
vim.o.timeoutlen = 6000
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.compatible = false
vim.opt.ignorecase = true -- Игнорировать регистр при поиске
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.cindent = false
vim.opt.softtabstop = 4
vim.cmd(":syntax enable")
vim.cmd(":syntax on")
vim.cmd(":set foldmethod=indent")
vim.cmd(":set foldcolumn=4")
vim.cmd(":set foldlevel=99")
-- Highlight the current line
vim.opt.cursorline = true

-- Disable preview window in comple
vim.opt.completeopt:remove("preview")
-- -- Автоматическое сохранение сессии при выходе
-- vim.cmd("autocmd VimLeave * mksession! ~/.config/nvim/session.vim")
-- keymap("n", "<leader>ss", ":source ~/.config/nvim/session.vim<CR>", { noremap = true })
keymap("n", "<C-;>", "zz", { noremap = true })
keymap("n", "<C-p>", "o<Left><Right><Esc>", { noremap = true })
-- Перемещение текущей строки в центр экрана при нажатии Ctrl + l в режиме вставки
keymap("i", "<C-;>", "<C-o>zz", { noremap = true, silent = true })
-- keymap("n", "<C-a>", "^", { noremap = true, silent = true })
-- keymap("n", "<C-e>", "$", { noremap = true })
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
keymap("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true })
keymap("n", "<C-j>", ":wincmd j<CR>", { noremap = true, silent = true })
-- Копирование выделенного текста в системный буфер обмена с помощью Cmd+C
keymap("v", "<D-c>", '"+y', { noremap = true, silent = true })
-- keymap("v", "J", ":m '>+1<CR>gv=gv")
-- keymap("v", "K", ":m '>-2<CR>gv=gv")

vim.cmd(':xnoremap <leader>p "_dP')
vim.cmd(":autocmd BufWritePre *.vim :normal gg=G``")

function RunCode()
	-- Сохраняем текущий файл
	vim.cmd("w")
	-- Получаем тип файла
	local filetype = vim.bo.filetype

	-- Таблица соответствий типов файлов и команд для запуска
	local run_cmds = {
		python = "!python3 %",
		lua = "!lua %",
		-- Вы можете добавить другие языки по необходимости
		javascript = "!node %",
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

keymap("n", "<leader>rc", ":lua RunCode()<CR>", { noremap = true, silent = true })

-- Глобальная переменная для отслеживания состояния раскладки
_G.is_russian = false

-- Функция для переключения раскладки
function _G.toggle_keymap()
	if _G.is_russian then
		vim.o.keymap = ""
		_G.is_russian = false
	else
		vim.o.keymap = "russian-jcukenwin"
		_G.is_russian = true
	end
end

-- Настройка сочетаний клавиш
keymap("n", "<C-Space>", ":lua toggle_keymap()<CR>", { noremap = true, silent = true })
keymap("i", "<C-Space>", "<C-o>:lua toggle_keymap()<CR>", { noremap = true, silent = true })

keymap("i", "<Plug>luasnip-expand-snippet", '<cmd>lua require("luasnip").expand()<CR>', { silent = true })
keymap("i", "<Plug>luasnip-jump-next", '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })

keymap("i", "<C-f>", "<Tab>", { noremap = true, silent = true })

-- Отмена последнего действия при нажатии Ctrl + / в режиме вставки
keymap("i", "<C-/>", "<C-o>u", { noremap = true, silent = true })
-- keymap("i", "<C-r>", "<C-o><C-r>", { noremap = true, silent = true })

-- Меняем текущую дирректорию
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("silent! lcd %:p:h")
	end,
})
keymap("n", "<leader>h", ":nohlsearch<CR>")

-- resize window
keymap("n", "_", ":resize -1<CR>")
keymap("n", "+", ":resize +1<CR>")
keymap("n", "<leader>sv", ":w<CR>:source %<CR>")
keymap("v", "<leader>sv", ":<c-u>w<CR>:source %<CR>")
keymap("c", "<C-k>", "<C-h>", { desc = "Delete char" })
keymap("i", "<C-k>", "<C-h>", { desc = "Delete char" })
keymap("i", "<C-h>", "<Left>", { desc = "Move cursor left in insert mode" })
keymap("c", "<C-h>", "<Left>", { desc = "Move cursor left in insert mode" })
keymap("i", "<C-l>", "<Right>", { desc = "Move cursor right in insert mode" })
keymap("c", "<C-l>", "<Right>", { desc = "Move cursor right in insert mode" })
keymap("i", "<C-CR>", "<esc>o", { noremap = true })
keymap("i", "<C-j>", "<esc>o", { noremap = true })
keymap("n", "<leader>ni", ":Neorg index<CR>", { desc = "Move cursor right in insert mode" })
keymap("n", "<leader>R", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
keymap("n", "<leader>N", ":set number!<CR>", { desc = "Toggle number" })
keymap("n", "<leader>T", ":lua MiniFiles.open()<cr>", { desc = "Open Mini.files" })
keymap("n", "<leader>sa", "ggVG", { desc = "Select All" })
keymap("n", "<leader>ya", ":%y+<CR>", { desc = "Yank All" })
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

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- или любая другая группа подсветки
			timeout = 150, -- длительность подсветки в миллисекундах
		})
	end,
})
