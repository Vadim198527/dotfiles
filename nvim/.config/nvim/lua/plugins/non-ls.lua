return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- Загружать чуть раньше, чтобы инструменты были доступны
		dependencies = { "nvimtools/none-ls.nvim", "mason.nvim" }, -- Явная зависимость
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "prettier", "clang_format" },
				automatic_installation = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- Загружать чуть раньше
		dependencies = { "mason.nvim" }, -- Если mason-null-ls не управляет им
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.prettier.with({
						-- extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
						-- extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"css",
							"scss",
							"less",
							"html",
							"json",
							"jsonc", -- для package.json с комментариями
							"yaml",
							"markdown",
							"graphql",
						},
						prefer_local = "node_modules/.bin", -- Предпочитать локально установленный Prettier
					}),
					-- null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.formatting.clang_format.with({
						-- extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
						extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
					}),
				},
			})
			-- vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, {})
			vim.keymap.set("n", "<leader>bf", function()
				vim.lsp.buf.format({ async = true })
			end, {})
		end,
	},
}
