return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/docs/Org_files",
						},
						default_workspace = "notes",
					},
				},
				["core.keybinds"] = {},
				["core.itero"] = {},
			},
		})
		vim.api.nvim_create_autocmd("Filetype", {
			pattern = "norg",
			callback = function()
				vim.keymap.set("n", "<S-Right>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
				vim.keymap.set("n", "<localleader>tc", ":Neorg toc right<CR>", { buffer = true })
				vim.keymap.set("i", "<C-.>", "<Plug>(neorg.promo.promote)", { buffer = true })
				vim.keymap.set("i", "<C-,>", "<Plug>(neorg.promo.demote)", { buffer = true })
				vim.keymap.set("n", "<C-.>", "<Plug>(neorg.promo.promote)", { buffer = true })
				vim.keymap.set("n", "<C-,>", "<Plug>(neorg.promo.demote)", { buffer = true })
				vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
			end,
		})
		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}
