return {
	{
		{
			"mg979/vim-visual-multi",
			config = function()
				-- Функция для удобного назначения клавиш
                vim.g.VM_mouse_mappings = 1
				local opts = { noremap = true, silent = true }
				vim.api.nvim_set_keymap("n", "<M-LeftMouse>", "<Plug>(VM-Mouse-Cursor)", opts)
				vim.api.nvim_set_keymap("n", "<M-RightMouse>", "<Plug>(VM-Mouse-Word)", opts)
				vim.api.nvim_set_keymap("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)", opts)
			end,
		},
	},
}
