-- ~/.config/nvim/lua/plugins/lsp-config.lua

return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ruff",
				"ts_ls",
				"texlab",
				"vimls",
				"eslint",
				"html",
				"emmet_ls",
				"bashls",
				"jsonls",
				"cssls",
				-- "cucumber_language_server",
			},
			handlers = {
				function(server)
					require("lspconfig")[server].setup({})
				end,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		-- dependencies = { "saghen/blink.cmp" },
		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
			},
		},
		config = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>si", vim.lsp.buf.implementation, {})

			-- Отключаем диагностику по умолчанию

			vim.api.nvim_create_user_command("DisableDiagnostics", function()
				vim.diagnostic.config({
					virtual_text = false,
					signs = false,
					underline = false,
				})
			end, {})
			vim.api.nvim_create_user_command("EnableDiagnostics", function()
				vim.diagnostic.config({
					virtual_text = true, -- Отключаем виртуальный текст справа
					signs = true, -- Оставляем значки слева
					underline = true, -- Подчёркивание проблемного кода
					-- update_in_insert = false, -- Обновление только в нормальном режиме
					severity_sort = true, -- Сортировка по важности
					float = {
						source = true, -- Показывать источник ошибки
						header = "", -- Без заголовка
						-- prefix = "", -- Без префикса
					},
				})
			end, {})
			vim.cmd("DisableDiagnostics")

			-- Привязка клавиши для отключения диагностик
			vim.api.nvim_set_keymap("n", "<leader>dd", ":DisableDiagnostics<CR>", { noremap = true })
			-- Привязка клавиши для включения диагностик
			vim.api.nvim_set_keymap("n", "<leader>de", ":EnableDiagnostics<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>di", function()
				vim.diagnostic.open_float(nil, { focus = true })
			end, { noremap = true })
		end,
	},
}
