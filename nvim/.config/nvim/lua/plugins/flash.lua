return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		-- mofes = {
		--     search = {
		--         enabled = true
		--     }
		-- }
		highlight = { backdrop = false },
		modes = {
			search = {
				enabled = false,
			},
			char = {
				-- enabled = false,
				enabled = false,
				jump_labels = true,
				highlight = { backdrop = false },
			},
		},
		jump = {
			autojump = true,
			pos = "start",
		},
		label = {
			rainbow = {
				enabled = true,
				shade = 2,
			},
			style = "inline", ---@type "eol" | "overlay" | "right_align" | "inline",
		},
	},
    -- stylua: ignore
    keys = {
        { "<C-/>",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<C-_>",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
