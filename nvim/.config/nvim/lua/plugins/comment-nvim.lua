return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			sticky = true,
		})
		-- Настройка для <leader>lc, чтобы она выполняла ту же функцию, что и gcc
		vim.keymap.set("n", "<leader>lc", "<Plug>(comment_toggle_linewise_current)")
		-- Настройка для Ctrl-/ (C-/), чтобы она выполняла ту же функцию, что и gcc
		 vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)<CR>")
		vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)<CR>")
		-- Настройка для Ctrl-/ (C-/) в VISUAL режиме для комментирования выделенной области
		vim.keymap.set("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)")
		vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")
	end,
	opts = {},
}
