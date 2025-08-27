return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		-- какой адаптер где
		strategies = {
			chat = { adapter = "openai" },
			inline = { adapter = "openai" },
			cmd = { adapter = "openai" },
		},

		-- настройка адаптера (пример: модель по умолчанию)
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					schema = {
						model = { default = "gpt-5" }, -- замените на вашу
					},
				})
			end,
			-- Показывать только свои адаптеры и не дёргать выбор модели
			opts = {
				show_defaults = false,
				show_model_choices = false,
			},
		},

		-- лог, удобно при дебаге
		opts = {
			log_level = "INFO", -- DEBUG/TRACE для разбора проблем
		},

		-- UI-палитра действий (можно подключить telescope/mini.pick/snacks)
		display = {
			action_palette = { provider = "native" },
		},
	},
}
