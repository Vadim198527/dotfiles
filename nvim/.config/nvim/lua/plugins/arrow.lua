return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		-- or if using `mini.icons`
		-- { "echasnovski/mini.icons" },
	},
	opts = {
		-- ► главное: глобальный кэш, не зависящий от cwd/git
		global_bookmarks = true, -- один JSON «global»
		save_key = "global", -- явное имя файла-кэша (можно опустить)

		-- ► чтобы в меню сразу видеть, где лежит файл
		always_show_path = true, -- показывает полный путь
		full_path_list = {}, -- список исключений больше не нужен

		-- прочие настройки по вкусу
		leader_key = "<leader>;",
		buffer_leader_key = "<leader>.",
		show_icons = true,
		per_buffer_config = {
			lines = 4, -- Number of lines showed on preview.
			sort_automatically = true, -- Auto sort buffer marks.
			satellite = { -- default to nil, display arrow index in scrollbar at every update
				enable = false,
				overlap = true,
				priority = 1000,
			},
			zindex = 10, --default 50
			treesitter_context = nil, -- it can be { line_shift_down = 2 }, currently not usable, for detail see https://github.com/otavioschwanck/arrow.nvim/pull/43#issue-2236320268
		},
	},
}
