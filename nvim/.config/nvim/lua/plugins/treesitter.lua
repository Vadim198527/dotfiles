return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Your textobject-related config here
				textobjects = {
					select = {
						-- enable = true,
						enable = false,
						lookahead = true, -- Автоматический переход к следующему совпадению
						keymaps = {
							["af"] = "@call.outer", -- Выделение вызова функции целиком
							["if"] = "@call.inner", -- Выделение внутренней части вызова функции
							["aF"] = "@function.outer", -- Выделение определения функции целиком
							["iF"] = "@function.inner", -- Выделение тела функции
							-- Условные конструкции
							["ai"] = "@conditional.outer", -- if/else целиком
							["ii"] = "@conditional.inner", -- тело if/else

							-- Циклы
							["al"] = "@loop.outer", -- цикл целиком
							["il"] = "@loop.inner", -- тело цикла

							-- Блоки
							["ab"] = "@block.outer", -- блок целиком
							["ib"] = "@block.inner", -- содержимое блока

							-- Параметры
							["aa"] = "@parameter.outer", -- параметр с запятыми
							["ia"] = "@parameter.inner", -- только параметр
						},
					},
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- начать выделение
						node_incremental = "<CR>", -- увеличить выделение
						-- scope_incremental = "<S-CR>", -- увеличить до следующей области видимости
						node_decremental = "<BS>", -- уменьшить выделение
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"python",
					"javascript",
					"latex",
					"html",
					"css",
                    "c",
					"markdown",
					"markdown_inline",
					"norg",
					"vimdoc",
					"vim",
					"markdown", -- для документации
					"bash",
					"scheme",
					"clojure",
					"racket",
					-- "org",
				},
				autoinstall = true,
				-- ignore_install = { "org" },
				highlight = {
					enable = true,
					disable = { "latex" },
				},
				indent = {
					enable = true,
					disable = { "html" },
				},
				autopairs = { enable = true },
				-- autopairs = { enable = false },
			})
		end,
	},
}
