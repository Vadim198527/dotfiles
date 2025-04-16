return {
	"LintaoAmons/bookmarks.nvim",
	dependencies = {
		{ "kkharji/sqlite.lua" },
		{ "nvim-telescope/telescope.nvim" },
		{ "stevearc/dressing.nvim" }, -- optional: better UI
	},
	config = function()
		local opts = {} -- check the "./lua/bookmarks/default-config.lua" file for all the options
		require("bookmarks").setup(opts) -- you must call setup to init sqlite db
		vim.keymap.set(
			{ "n", "v" },
			"mm",
			"<cmd>BookmarksMark<cr>",
			{ desc = "Mark current line into active BookmarkList." }
		)
		vim.keymap.set(
			{ "n", "v" },
			"mo",
			"<cmd>BookmarksGoto<cr>",
			{ desc = "Go to bookmark at current active BookmarkList" }
		)
		vim.keymap.set(
			{ "n", "v" },
			"ma",
			"<cmd>BookmarksCommands<cr>",
			{ desc = "Find and trigger a bookmark command." }
		)
	end,
}

-- run :BookmarksInfo to see the running status of the plugin
