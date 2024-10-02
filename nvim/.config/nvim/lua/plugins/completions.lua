return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-cmdline",
			"f3fora/cmp-spell",
			"micangl/cmp-vimtex",
			-- "saadparwaiz1/cmp_luasnip",
		},

		config = function()
			local cmp = require("cmp")
			-- Инициализация nvim-cmp и nvim-autopairs
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			-- Настройка nvim-autopairs
			require("nvim-autopairs").setup({})

			-- Интеграция nvim-autopairs с nvim-cmp
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				performance = {
					trigger_debounce_time = 500,
					throttle = 550,
					fetching_timeout = 80,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip", option = { use_show_condition = false } }, -- For luasnip users.
					-- { name = "ultisnips" }, -- For ultisnips users.
					{ name = "vimtex" },
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
					-- { name = "buffer" },
				},
			})

			-- Отключаем автодополнение для файлов с расширением .txt
			-- cmp.setup.filetype("txt", {
			-- 	enabled = false, -- Отключаем nvim-cmp для файлов .txt
			-- })
			cmp.setup.filetype("text", {
				enabled = false, -- Отключаем nvim-cmp для файлов .txt
			})

			cmp.setup.filetype("tex", {
				enabled = false, -- Отключаем nvim-cmp для файлов .tex
			})
		end,
	},
}
