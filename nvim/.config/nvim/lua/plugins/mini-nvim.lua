return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.indentscope").setup()
			require("mini.icons").setup()
			require("mini.files").setup()
			require("mini.animate").setup({
				scroll = {
					timing = require("mini.animate").gen_timing.linear({ duration = 125, unit = "total" }),
				},
                cursor = {
                    enable = false
                },
			})
		end,
	},
}
