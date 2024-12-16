return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		-- config = function()
		--     local mason = require("mason").setup({})
		-- end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local mason = require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ruff",
					"ts_ls",
					"texlab",
					"ltex",
					"vimls",
					"eslint",
					"html",
					"cssls",
					"emmet_ls",
				}, -- "ltex", "texlab"
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.ruff.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.vimls.setup({ capabilities = capabilities })
			lspconfig.eslint.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "templ" }, -- добавляем явное указание типов файлов
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
			})
			lspconfig.emmet_ls.setup({ capabilities = capabilities })
			-- lspconfig.ltex.setup({ capabilities = capabilities })
			-- lspconfig.texlab.setup({ capabilities = capabilities })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>si", vim.lsp.buf.implementation, {})
			vim.api.nvim_create_user_command("DisableDiagnostics", function()
				vim.diagnostic.config({
					virtual_text = false,
					signs = false,
					underline = false,
				})
			end, {})
			vim.api.nvim_create_user_command("EnableDiagnostics", function()
				vim.diagnostic.config({
					virtual_text = true,
					signs = true,
					underline = true,
				})
			end, {})
			-- Привязка клавиши для отключения диагностик
			vim.api.nvim_set_keymap("n", "<leader>dd", ":DisableDiagnostics<CR>", { noremap = true })
			-- Привязка клавиши для включения диагностик
			vim.api.nvim_set_keymap("n", "<leader>de", ":EnableDiagnostics<CR>", { noremap = true })
		end,
	},
}
