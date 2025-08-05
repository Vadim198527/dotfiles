return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Your textobject-related config here
				textobjects = {
					lsp_interop = {
						enable = true,
						border = "single",
						floating_preview_opts = {},
						peek_definition_code = {
							-- ["<leader>df"] = "@function.outer",
						},
					},
					select = {
						-- enable = true,
						enable = true,
						lookahead = true, -- Автоматический переход к следующему совпадению
						keymaps = {
							["af"] = "@call.outer", -- Выделение вызова функции целиком
							["if"] = "@call.inner", -- Выделение внутренней части вызова функции
							["aF"] = "@function.outer", -- Выделение определения функции целиком
							["if"] = "@function.inner", -- Выделение тела функции
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
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["<leader>ns"] = "@function.outer",
							-- ["]]"] = "@class.outer",
						},
						goto_next = {
							["]f"] = { query = { "@function.inner", "@function.outer" } },
							["]["] = "@class.outer",
						},
						-- goto_previous_start = {
						-- 	["[m"] = "@function.outer",
						-- 	["[["] = "@class.outer",
						-- },
						-- goto_previous_end = {
						-- 	["[M"] = "@function.outer",
						-- 	["[]"] = "@class.outer",
						-- },
					},
					swap = {
						enable = true,
						swap_next = { ["<leader>sp"] = "@parameter.inner" },
						swap_previous = { ["<leader>sP"] = "@parameter.inner" },
					},
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						-- init_selection = "<CR>", -- начать выделение
						-- node_incremental = "<CR>", -- увеличить выделение
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
			local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

			-- Add custom parser for Gherkin (Cucumber)
			parser_configs.gherkin = {
				install_info = {
					url = "https://github.com/SamyAB/tree-sitter-gherkin.git",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "cucumber", -- Associates with Neovim's default filetype for .feature files
			}
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"python",
					"javascript",
					"typescript",
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
					"gherkin",
					-- "org",
				},
				autoinstall = true,
				-- ignore_install = { "org" },
				highlight = {
					enable = true,
					-- disable = { "latex" },
				},
				indent = {
					enable = true,
					disable = { "html" },
				},
				-- autopairs = { enable = true },
				-- autopairs = { enable = false },

				-- чтобы старые режимы не мешали
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "python",
					callback = function()
						vim.bo.smartindent = false
						vim.bo.cindent = false
					end,
				}),
			})
		end,
	},
}
