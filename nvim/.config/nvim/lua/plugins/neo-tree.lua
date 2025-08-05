return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		----------------------------------------------------------------------------
		-- ░ 1.  базовая настройка
		----------------------------------------------------------------------------
		require("neo-tree").setup({
			window = { 
                width = 28,
                mappings = {
                    ["Y"] = function(state)
                        local node = state.tree:get_node()
                        local filepath = node.path
                        vim.fn.setreg("+", filepath)
                        vim.notify("Copied absolute path: " .. filepath)
                    end,
                    ["y"] = function(state)
                        local node = state.tree:get_node()
                        local relpath = vim.fn.fnamemodify(node.path, ":.")
                        vim.fn.setreg("+", relpath)
                        vim.notify("Copied relative path: " .. relpath)
                    end,
                },
            }, -- узкие панели
			filesystem = {
				bind_to_cwd = false, -- дерево ≠ cwd  (cwd в покое)
				-- follow_current_file = { enabled = false },
				follow_current_file = { enabled = true },
			},
			enable_git_status = false,
		})

		vim.keymap.set("n", "<leader>t", function()
			vim.cmd("Neotree toggle filesystem position=left dir=" .. vim.fn.fnameescape(vim.loop.cwd()))
		end, { silent = true, desc = "Neo-tree @ cwd (left)" }) -- встроенный toggle закроет панель, если она уже открыта
        
		vim.keymap.set("n", "<leader>T", function()
			vim.cmd("Neotree toggle filesystem position=left dir=" .. vim.fn.fnameescape(vim.fn.expand("%:p:h")))
		end, { silent = true, desc = "Neo-tree @ cwd (left)" }) -- встроенный toggle закроет панель, если она уже открыта
	end,
}
