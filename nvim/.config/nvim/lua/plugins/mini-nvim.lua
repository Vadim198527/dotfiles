return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.indentscope").setup()
			require("mini.icons").setup()
			require("mini.animate").setup({
				scroll = {
					timing = require("mini.animate").gen_timing.linear({ duration = 125, unit = "total" }),
				},
                cursor = {
                    enable = false
                },
			})
			-- require("mini.surround").setup()
			-- require('mini.notify').setup()
		end,
	},
	--   {
	--       "echasnovski/mini.indentscope",
	--       version = false,
	-- config = function()
	-- 	require("mini.indentscope").setup()
	-- end,
	--   },
	--   {
	--       "echasnovski/mini.icons",
	--       version = false,
	--       config = function()
	--           require("mini.icons").setup()
	--       end,
	--   },
}
