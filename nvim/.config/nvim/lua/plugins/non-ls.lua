return {
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "eslint_d", "prettier", "clang_format" },
				automatic_installation = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.prettier.with({
						-- extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
						extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
					}),
					-- null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.formatting.clang_format.with({
						-- extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
						extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
					}),
					-- null_ls.builtins.diagnostics.ruff,
				},
			})
			vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, {})
		end,
	},
}
