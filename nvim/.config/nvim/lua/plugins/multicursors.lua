return {
	"mg979/vim-visual-multi",
	init = function()
		-- enable the mouse mappings
		vim.g.VM_mouse_mappings = 1

		-- define all your overrides in one Lua table
		vim.g.VM_maps = {
			-- ["Add Cursor At Position"] = ",qq",

			-- you can put other overrides here too, for example:
			["Select All"] = "<leader>ma",
			["Start Regex Search"] = "<leader>mr",
			-- ["Add Cursor Down"]     = "<M-j>",
			-- ["Add Cursor Up"]       = "<M-k>",
		}
	end,
	config = function()
	end,
}
