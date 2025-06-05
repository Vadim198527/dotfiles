return {
	{
		"echasnovski/mini.nvim",
		version = false,
		lazy = false,
		config = function()
			-- local ai = require("mini.ai")
			-- ai.setup({
			--     custom_textobjects = {
			--         F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			--     },
			-- })
			-- require("mini.surround").setup({
			-- 	custom_surroundings = nil,
			-- 	mappings = {
			-- 		add = "ys",
			-- 		delete = "ds",
			-- 		find = "",
			-- 		find_left = "",
			-- 		highlight = "",
			-- 		replace = "cs",
			-- 		update_n_lines = "",
			--
			-- 		-- Add this only if you don't want to use extended mappings
			-- 		suffix_last = "l",
			-- 		suffix_next = "n",
			-- 	},
			-- })
			require("mini.operators").setup({})
			require("mini.pairs").setup()
			local map_bs = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
			end
			map_bs("<C-h>", "v:lua.MiniPairs.bs()")
			map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
			map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')
			map_bs("<CR>", "v:lua.MiniPairs.cr()")
			-- -- Отключаем атодополнение ' для .rkt файлов
			-- vim.api.nvim_create_autocmd("FileType", {
			--     pattern = "racket",
			--     callback = function()
			--         -- Unmap the ' key in the current buffer and unregister its pairing
			--         require("mini.pairs").unmap_buf(0, "i", "'", "''")
			--     end,
			-- })

			-- require("mini.indentscope").setup({
			--     draw = {
			--         -- Линейная анимация со средним временем шага 10 мс
			--         animation = require('mini.indentscope').gen_animation.linear({ duration = 15, unit = 'step' }),
			--         delay = 50, -- Опционально: уменьшить начальную задержку
			--     },
			--     opts = {
			--         border = "bottom",
			--     },
			-- })
			require("mini.icons").setup()
			require("mini.files").setup()
			-- require("mini.jump2d").setup({
			--     mappings = {
			--         start_jumping = "<C-_>",
			--     },
			-- })
			-- require("mini.animate").setup({
			--     scroll = {
			--         timing = require("mini.animate").gen_timing.linear({ duration = 125, unit = "total" }),
			--     },
			--     cursor = {
			--         enable = false,
			--     },
			-- })

			require("mini.sessions").setup({

				-- Whether to read default session if Neovim opened without file arguments
				autoread = true,

				-- Whether to write currently read session before quitting Neovim
				autowrite = true,

				-- Directory where global sessions are stored (use `''` to disable)
				directory = "~/Desktop/Sessions/", --<"session" subdir of user data directory from |stdpath()|>,

				-- File for local session (use `''` to disable)
				file = "",

				-- Whether to force possibly harmful actions (meaning depends on function)
				force = { read = false, write = true, delete = false },

				-- Hook functions for actions. Default `nil` means 'do nothing'.
				hooks = {
					-- Before successful action
					pre = {
						write = function()
							-- pcall = на случай, если плагин ещё не загружен
							pcall(require("neo-tree.command").execute, { action = "close" })
						end,
					},
					-- After successful action
					post = { read = nil, write = nil, delete = nil },
				},

				-- Whether to print session path after action
				verbose = { read = false, write = true, delete = true },
			})
			vim.keymap.set(
				"n",
				"<leader>sw",
				':lua MiniSessions.select("write")<cr>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>sl", ':lua MiniSessions.select("read")<cr>', { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"<leader>sd",
				':lua MiniSessions.select("delete")<cr>',
				{ noremap = true, silent = true }
			)
		end,
	},
}
