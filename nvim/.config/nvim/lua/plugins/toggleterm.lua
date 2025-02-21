return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {},
	config = function()
		require("toggleterm").setup({
			size = 10,
            start_in_insert = true,
			autochdir = true,
			open_mapping = [[<c-\>]],
			-- direction = 'float',
			direction = "horizontal",
			close_on_exit = true,
			insert_mappings = false,
		})

		local function olan()
			vim.cmd("write")
			vim.cmd('TermExec cmd="gcc -o a.out % && ./a.out"')
		end

		-- Устанавливаем маппинг только для файлов .c
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "c",
		-- 	callback = function()
		-- 		vim.keymap.set("n", "<leader>rc", olan, { buffer = true })
		-- 	end,
		-- })
	end,
}
