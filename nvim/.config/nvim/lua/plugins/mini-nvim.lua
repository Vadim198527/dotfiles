return {
	{
		"echasnovski/mini.nvim",
		version = false,
		lazy = false,
		config = function()
			require("mini.operators").setup({})
			require("mini.pairs").setup()
			local map_bs = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
			end
			map_bs("<C-h>", "v:lua.MiniPairs.bs()")
			map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
			map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')
			map_bs("<CR>", "v:lua.MiniPairs.cr()")
			require("mini.icons").setup()
			require("mini.files").setup()
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
            
			require("mini.ai").setup()

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
