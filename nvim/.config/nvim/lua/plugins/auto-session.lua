return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>sl", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
	},
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- log_level = 'debug',
		auto_save = true,
		auto_restore = true,
		auto_create = false,
		previewer = false, -- File preview for session picker
		root_dir = vim.fn.stdpath("data") .. "/sessions/",
		close_unsupported_windows = true,

		mappings = {
			-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
			delete_session = { "i", "<C-D>" },
			alternate_session = { "i", "<C-S>" },
			copy_session = { "i", "<C-Y>" },
		},
	},

	config = function()
		-- Инициализация AutoSession
		require("auto-session").setup({
			-- Директория для сохранения сессий
			root_dir = vim.fn.stdpath("data") .. "/sessions/",

			-- Автоматическое сохранение и восстановление
			auto_save = true,
			auto_restore = true,
			auto_create = false,
			-- Отключение обработки изменения cwd, если не требуется
			cwd_change_handling = false,

			-- Настройки session_lens (опционально)
			session_lens = {
				load_on_setup = true,
				previewer = false,
				mappings = {
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
					copy_session = { "i", "<C-Y>" },
				},
			},
			-- Исключаем 'curdir' из session_options
			session_options = {
				"buffers", -- Сохраняет открытые буферы
				"tabpages", -- Сохраняет открытые табы
				"winsize", -- Сохраняет размеры окон
				-- 'curdir',      -- Исключаем 'curdir', чтобы избежать команды `cd`
				"globals", -- Сохраняет глобальные переменные
				"help", -- Сохраняет буферы help
				"localoptions", -- Сохраняет локальные опции
				"terminal", -- Сохраняет терминальные буферы
			},
		})

		-- Настройка sessionoptions
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
}
