return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			-- open file_browser with the path of the current buffer
			-- vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
			vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
			-- vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true, silent = true})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						cwd_to_path = true,
						hidden = true,
						follow_symlinks = true,
					},
					fzf = {
						fuzzy = true, -- включить нечеткий поиск
						override_generic_sorter = true, -- переопределить общий сортировщик
						override_file_sorter = true, -- переопределить сортировщик файлов
						case_mode = "smart_case", -- использовать умный регистр
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-d>"] = require("telescope.actions").delete_buffer,
							["<C-o>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								-- Для macOS заменить на:
								vim.fn.jobstart({ "open", selection.path })
							end,
						},
						n = {
							["d"] = require("telescope.actions").delete_buffer,
						},
					},
					path_display = { "tail" },
					-- path_display = { "smart" },
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Open file" })
			vim.keymap.set("n", "<leader>.", builtin.find_files, { desc = "Open file" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fine grep" })
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Old files" })
			-- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Change color scheme" })
			vim.keymap.set("n", "<leader>ma", builtin.marks, { desc = "Display marks" })
			vim.keymap.set("n", "<leader>rg", builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Key maps" })
			vim.keymap.set(
				"n",
				"<leader>ds",
				builtin.lsp_document_symbols,
				{ desc = "Show all buffer lexical entities" }
			)
			vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "Key maps" })
			-- vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Key maps" })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rn",
				"<cmd>lua vim.lsp.buf.rename()<CR>",
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>fp", "<cmd>TelescopePath<CR>", { desc = "Key maps" })
			-- vim.api.nvim_set_keymap(
			-- 	"c",
			-- 	"<C-p>",
			-- 	'<Cmd>lua require("telescope.builtin").commands()<CR>',
			-- 	{ noremap = true, silent = true }
			-- )

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("file_browser")
			vim.api.nvim_create_user_command("TelescopePath", function()
				vim.ui.input({ prompt = "Path: ", completion = "dir" }, function(path)
					if path then
						require("telescope.builtin").find_files({ cwd = path })
					end
				end)
			end, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
