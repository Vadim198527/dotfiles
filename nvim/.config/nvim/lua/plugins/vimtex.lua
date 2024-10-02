return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "skim"
		-- vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_view_skim_activate = 1
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_quickfix_mode = 0
		vim.g.tex_flavor = "latex"
		vim.o.conceallevel = 1
		vim.g.tex_conceal = "abdmg"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.keymap.set("n", "<C-t>", "<plug>(vimtex-env-toggle-math)", { buffer = true })
			end,
		})
	end,
}
