-- В твоем файле конфигурации lazy.nvim
return {
	"mg979/vim-visual-multi",
	init = function()
		vim.cmd([[let g:VM_leader = {'default': '\\'}]])
		vim.cmd([[let g:VM_maps = {}]])
		-- vim.cmd([[let g:VM_maps['Add Cursor Down'] = '<M-j>']])
		-- vim.cmd([[let g:VM_maps['Add Cursor Up'] = '<M-k>']])
		vim.cmd([[let g:VM_maps['Select All'] = '<leader>ma']])
        vim.cmd([[let g:VM_maps['Start Regex Search'] = '<leader>mr']])
		vim.g.VM_mouse_mappings = 1
	end,
	config = function()
		-- Конфигурация после загрузки (если нужна)
	end,
}
