return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>sl", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
	},
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- log_level = 'debug',
		auto_save = true,
		auto_restore = true,
		auto_create = false,
		previewer = false, -- File preview for session picker

		mappings = {
			-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
			delete_session = { "i", "<C-D>" },
			alternate_session = { "i", "<C-S>" },
			copy_session = { "i", "<C-Y>" },
		},
	},
}
