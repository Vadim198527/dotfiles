return {
	"folke/trouble.nvim",
	opts = {}, -- Использует настройки по умолчанию. Для кастомизации см. ниже.
	cmd = "Trouble", -- Ленивая загрузка: плагин загрузится при вызове команды Trouble
	keys = {
		-- Эта секция настраивает горячие клавиши для вызова Trouble.
		-- <leader> - это ваша главная клавиша-модификатор (обычно `пробел` или `\`)
		{
			"<leader>da",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Диагностика (весь проект)",
		},
		{
			"<leader>df",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Диагностика (текущий файл)",
		},
		-- {
		-- 	"<leader>cs",
		-- 	"<cmd>Trouble symbols toggle focus=false<cr>",
		-- 	desc = "Символы документа",
		-- },
		-- {
		-- 	"<leader>cl",
		-- 	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		-- 	desc = "LSP определения, ссылки и т.д.",
		-- },
		-- {
		-- 	"<leader>xL",
		-- 	"<cmd>Trouble loclist toggle<cr>",
		-- 	desc = "Location List",
		-- },
		-- {
		-- 	"<leader>xQ",
		-- 	"<cmd>Trouble qflist toggle<cr>",
		-- 	desc = "Quickfix List",
		-- },
	},
}
