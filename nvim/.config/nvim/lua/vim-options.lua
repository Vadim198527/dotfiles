vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.timeout = true
-- sldkfj

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
vim.opt.hidden = true
-- vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#b3e0a7", fg = "NONE" })
-- vim.api.nvim_set_hl(0, "CursorVisual", { bg = "orange", fg = "NONE" })
-- 3) Настраиваем guicursor
-- vim.opt.guicursor = {
--     -- normal, visual, command-line
--     "n-v-c:block-CursorNormal",
--     -- insert (block + новая группа)
--     "i:block-CursorInsert",
--     "v-ve:block-CursorVisual",
--     -- replace
--     "r-cr:block-CursorNormal",
--     -- operator-pending (можно оставить block)
--     "o:hor50-CursorNormal",
-- }
vim.opt.compatible = false
vim.opt.ignorecase = true -- Игнорировать регистр при поиске
vim.opt.smartcase = true
vim.opt.incsearch = true -- Подсвечивать совпадения по мере ввода
vim.opt.conceallevel = 2 -- 1: скрывать, когда курсор не на строке;
vim.opt.concealcursor = "nc"
-- vim.opt.concealcursor = ''
-- vim.opt.clipboard = "unnamedplus"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.softtabstop = 4
-- vim.opt.autochdir = true
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.hlsearch = false

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.opt.undolevels = 200

-- bora
-- vim.cmd([[
-- 	let g:python_indent = {}
-- 	let g:python_indent.disable_parentheses_indenting = v:false
-- 	let g:python_indent.closed_paren_align_last_line = v:false
-- 	let g:python_indent.searchpair_timeout = 150
-- 	let g:python_indent.continue = 'shiftwidth()'
-- 	let g:python_indent.open_paren = 'shiftwidth()'
-- 	let g:python_indent.nested_paren = 'shiftwidth()'
-- ]])

-- Добавьте это в init.lua
vim.filetype.add({
	extension = {
		rkt = "racket",
	},
})
-- Делаем так, чтобы нажатие o не создавало строку с комментарием
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})

-- vim.opt.formatoptions:remove('o')
vim.cmd(":syntax enable")
vim.cmd(":syntax on")
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldlevel = 99

vim.opt.cursorline = true
vim.o.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal"
vim.lsp.set_log_level("ERROR")  -- Только ошибки; альтернативы: "WARN" (default), "INFO", "DEBUG", "OFF" (отключить полностью)

-- Disable preview window in comple
vim.opt.completeopt:remove("preview")
vim.cmd(":autocmd BufWritePre *.vim :normal gg=G``")
vim.cmd([[autocmd TermOpen * startinsert | terminal]])

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

-- function _G.set_vim_layout(layout_name)
-- 	if layout_name == "english" then
-- 		-- Для английского отключаем и keymap, и input method
-- 		vim.o.keymap = ""
-- 		_G.is_russian = false
-- 	elseif layout_name == "russian" then
-- 		-- Для русского включаем keymap и отключаем input method
-- 		vim.o.keymap = "russian-jcukenwin"
-- 		_G.is_russian = true
-- 	end
-- end



-- vim.keymap.set("i", "<C-Space>", function()k длоk lsdfkj ыва kjkk ыва 
-- 	set_vim_layout("russian") 
-- 	_G.is_russian = true
-- end, { desc = "Switch to Russian (Vim)" })

-- -- Пиньинь: Пробел + l
-- -- (Вы дважды указали 'k', я предполагаю, что для пиньинь имелся в виду 'l')
-- vim.keymap.set("i", "<leader>all", function()
-- 	set_vim_layout("pinyin")
-- end, { desc = "Switch to Pinyin (Vim)" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- или любая другая группа подсветки
			timeout = 150, -- длительность подсветки в миллисекундах
		})
	end,
})
-- 1. Указываем, что цель - tmux
vim.g.slime_target = "tmux"

-- 2. Задаем конфигурацию по умолчанию, чтобы избежать вопросов
vim.g.slime_default_config = {
	-- Имя сокета tmux. "default" почти всегда правильно, если ты не запускал tmux с особыми флагами -L или -S.
	socket_name = "default",
	-- Целевая панель. "{last}" - панель, активная перед текущей. Идеально для переключения Neovim <-> REPL.
	target_pane = "{last}",
}

-- 3. (Рекомендуется) Включаем bracketed paste для tmux
-- Это помогает корректно вставлять многострочный код в REPL.
vim.g.slime_bracketed_paste = 1
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Вариант А: Точно как основной фон
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e" })

		-- Вариант Б: Чуть темнее (Mantle)
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#181825" })

		-- Опционально: Настроить цвет выделения
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#313244" }) -- Surface0
		-- *** УСТАНАВЛИВАЕМ ЦВЕТ РАМКИ ***
		-- Используем цвет 'Crust' как цвет переднего плана (fg) для рамки
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#6c7086" })
	end,
})

-- -- init.lua
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern  = { 'tex', 'latex' },
--   callback = function() require('pretty_math').attach() end,
-- })

-- где-нибудь после остальных require:
require("mdlist").setup()


