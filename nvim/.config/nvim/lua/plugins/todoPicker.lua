return {
	dir = vim.fn.stdpath("config") .. "/lua/todo_picker", -- папка с init.lua
	name = "todo-picker.nvim",
	lazy = false, -- или true, если хотите загружать по требованию
	config = function()
		require("todo_picker").setup({
			todo_file = "~/todo.md",
			keymaps = { add = "<localleader>ta", list = "<localleader>tt" },
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
}
