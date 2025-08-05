return {
	"yioneko/nvim-yati",
	dependencies = "nvim-treesitter/nvim-treesitter",
	event = "VeryLazy", -- загружать, когда нужен indent
	config = function()
		require("nvim-treesitter.configs").setup({
			-- оставляем хайлайт, текст-объекты и т.д.
			highlight = { enable = true },
			indent = { -- штатный модуль
				enable = true,
				disable = { "python", "lua" }, -- <-- отключаем ТОЛЬКО python
			},
			-- включаем Yati (работает для всех языков или выборочно)
			yati = {
				enable = true, -- ② Yati активен
				default_lazy = true,
				suppress_conflict_warning = true, -- ③ убираем всплывашку
			},
		})
	end,
}
