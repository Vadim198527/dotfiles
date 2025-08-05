return {
	"Saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Опционально, но часто используется с lspkind
		"onsails/lspkind.nvim",
		-- ... ваши другие зависимости ...
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		snippets = {
			-- preset = "luasnip",
			-- Function to use when expanding LSP provided snippets
			expand = function(snippet)
				vim.snippet.expand(snippet)
			end,
			-- Function to use when checking if a snippet is active
			active = function(filter)
				return vim.snippet.active(filter)
			end,
			-- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
			jump = function(direction)
				vim.snippet.jump(direction)
			end,
		},

		keymap = {
			-- preset = "super-tab", -- Начнем с чистого листа для ясности
			preset = "none", -- Убираем любые дефолтные пресеты
			["<Tab>"] = {
				function(cmp)
					cmp.hide()
				end,
				"fallback",
			},
			-- ["<CR>"] = { "accept", "fallback" },
			-- ["<C-Space>"] = {},
			["<C-space>"] = {},
			["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },

		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
				},
			},
			list = { selection = { preselect = false, auto_insert = true } },
			menu = {
				border = "rounded",
				scrollbar = false,
				-- Don't automatically show the completion menu
				auto_show = true,

				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", gap = 1 },
						{ "kind" },
					},
				},
			},
		},
        signature = {enabled = false},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "buffer" },
			-- Добавляем эту функцию для фильтрации
			-- transform_items = function(_, items)
			--     -- Загружаем типы, если еще не загружены
			--     local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
			--     -- Возвращаем только те элементы, у которых kind НЕ Snippet
			--     return vim.tbl_filter(function(item)
			--         return item.kind ~= CompletionItemKind.Snippet
			--     end, items)
			-- end,
			providers = {
				-- главное изменение ↓↓↓
				lsp = {
					async = true, -- не блокировать меню, пока lua_ls думает
                    fallbacks = {},
					-- debounce = 40, -- (опц.) задержка между запросами, мс
					-- fetching_timeout = 40, -- (опц.) сколько ждать первого пакета
					-- min_keyword_length = 2, -- у вас уже так
				},
			},
			min_keyword_length = function(ctx)
				-- ctx - это объект контекста, который передает blink.cmp
				-- Он содержит информацию о текущем состоянии, включая режим
				-- Стандартные режимы: 'insert', 'cmdline', 'term'
				if ctx.mode == "cmdline" then
					-- В командной строке запускать сразу (после 1 символа)
					return 0
				else
					-- В других режимах (например, 'insert') запускать после 3 символов
					return 2
				end
			end,
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information:
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = {
			enabled = true,
			-- use 'inherit' to inherit mappings from top level `keymap` config
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = {},
				},
				list = {
					selection = {
						-- When `true`, will automatically select the first item in the completion list
						preselect = false,
						-- When `true`, inserts the completion item automatically when selecting it
						auto_insert = true,
					},
				},
				-- Whether to automatically show the window when new completion items are available
				menu = { auto_show = true },
				-- Displays a preview of the selected item on the current line
				ghost_text = { enabled = true },
			},
			keymap = {
				["<tab>"] = { "select_and_accept" },
			},
		},
		-- cmdline = {
		--     -- Модифицируем функцию sources
		--     completion = {
		--         menu = {
		--             auto_show = true,
		--         },
		--         list = {
		--             selection = {
		--                 preselect = false,
		--                 -- Также рекомендуется отключить auto_insert, раз preselect отключен
		--                 auto_insert = true,
		--             },
		--         },
		--     },
		--     keymap = {
		--         ["<tab>"] = { "select_and_accept" },
		--     },
		-- },
	},
	-- opts_extend = { "sources.default" },
}
