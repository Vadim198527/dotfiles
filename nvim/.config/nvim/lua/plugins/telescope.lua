-- return {
--     {
--         "nvim-telescope/telescope-fzf-native.nvim",
--         -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
--         build = "make CMAKE_ARGS='-DCMAKE_POLICY_VERSION_MINIMUM=3.5'",
--     },
--     {
--         "nvim-telescope/telescope-file-browser.nvim",
--         dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
--         config = function()
--             -- open file_browser with the path of the current buffer
--             -- vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
--             vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
--             -- vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true, silent = true})
--         end,
--     },
--     {
--         "nvim-telescope/telescope.nvim",
--         -- tag = "0.1.8",
--         dependencies = { "nvim-lua/plenary.nvim" },
--         config = function()
--             require("telescope").setup({
--                 pickers = {
--                     find_files = {
--                         hidden = true,
--                     },
--                     buffers = {
--                         ignore_current_buffer = true,
--                         sort_mru = true,
--                     },
--                 },
--                 extensions = {
--                     ["ui-select"] = {
--                         require("telescope.themes").get_dropdown({}),
--                     },
--                     file_browser = {
--                         cwd_to_path = true,
--                         hidden = true,
--                         follow_symlinks = true,
--                     },
--                     fzf = {
--                         fuzzy = true, -- включить нечеткий поиск
--                         override_generic_sorter = true, -- переопределить общий сортировщик
--                         override_file_sorter = true, -- переопределить сортировщик файлов
--                         case_mode = "smart_case", -- использовать умный регистр
--                     },
--                 },
--                 defaults = {
--                     mappings = {
--                         i = {
--                             ["<C-d>"] = require("telescope.actions").delete_buffer,
--                             ["<C-o>"] = function(prompt_bufnr)
--                                 local selection = require("telescope.actions.state").get_selected_entry()
--                                 require("telescope.actions").close(prompt_bufnr)
--                                 -- Для macOS заменить на:
--                                 vim.fn.jobstart({ "open", selection.path })
--                             end,
--                         },
--                         n = {
--                             ["d"] = require("telescope.actions").delete_buffer,
--                         },
--                     },
--                     path_display = { "tail" },
--                     -- path_display = { "smart" },
--                 },
--             })
--             local builtin = require("telescope.builtin")
--             -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Open file" })
--             vim.keymap.set("n", "<leader>ff", function()
--                 local buf_path = vim.fn.expand("%:p:h")
--                 builtin.find_files({ cwd = buf_path })
--             end, { desc = "Open file" })
--             vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fine grep" })
--             vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Old files" })
--             -- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
--             vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
--             vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Change color scheme" })
--             vim.keymap.set("n", "<leader>lsd", builtin.lsp_document_symbols, { desc = "Lsp Document's symbols" })
--             vim.keymap.set("n", "<leader>lsw", builtin.lsp_workspace_symbols, { desc = "Lsp Workspase's symbols" })
--             -- vim.keymap.set("n", "<leader>ma", builtin.marks, { desc = "Display marks" }d
--             vim.keymap.set("n", "<leader>rg", builtin.registers, { desc = "Registers" })
--             vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Key maps" })
--             vim.keymap.set(
--                 "n",
--                 "<leader>ds",
--                 builtin.lsp_document_symbols,
--                 { desc = "Show all buffer lexical entities" }
--             )
--             -- vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "Key maps" })
--             -- vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Key maps" })
--             vim.api.nvim_set_keymap(
--                 "n",
--                 "<leader>rn",
--                 "<cmd>lua vim.lsp.buf.rename()<CR>",
--                 { noremap = true, silent = true }
--             )
--             vim.keymap.set("n", "<leader>fp", "<cmd>TelescopePath<CR>", { desc = "Key maps" })
--             -- vim.api.nvim_set_keymap(
--             -- 	"c",
--             -- 	"<C-p>",
--             -- 	'<Cmd>lua require("telescope.builtin").commands()<CR>',
--             -- 	{ noremap = true, silent = true }
--             -- )
--
--             require("telescope").load_extension("fzf")
--             require("telescope").load_extension("ui-select")
--             require("telescope").load_extension("file_browser")
--             -- vim.api.nvim_create_user_command("TelescopePath", function()
--             --     vim.ui.input({ prompt = "Path: ", completion = "dir" }, function(path)
--             --         if path then
--             --             require("telescope.builtin").find_files({ cwd = path })
--             --         end
--             --     end)
--             -- end, {})
--         end,
--     },
--     {
--         "nvim-telescope/telescope-ui-select.nvim",
--     },
--
--     -- ~/.config/nvim/lua/plugins/telescope-undo.lua
--     -- {
--     --     "debugloop/telescope-undo.nvim",
--     --     dependencies = {
--     --         -- сам Telescope и его зависимость
--     --         {
--     --             "nvim-telescope/telescope.nvim",
--     --             dependencies = { "nvim-lua/plenary.nvim" },
--     --         },
--     --     },
--     --     -- Клавиша открытия undo-дерева (нормальный режим)
--     --     keys = {
--     --         { "<leader>u", "<cmd>Telescope undo<cr>", desc = "История undo" },
--     --     },
--     --     -- Опции – только то, что относится к расширению undo
--     --     opts = {
--     --         extensions = {
--     --             undo = {
--     --                 -- Показывать дифы рядом (требует delta)
--     --                 side_by_side = true,
--     --                 -- Чуть больше места превью
--     --                 -- layout_strategy = "vertical",
--     --                 layout_config = {
--     --                     preview_height = 0.65,
--     --                 },
--     --                 -- Дополнительно: выводить только сохранённые состояния
--     --                 -- saved_only = true,
--     --             },
--     --         },
--     --     },
--     --     config = function(_, opts)
--     --         -- объединяем конфиги Telescope из разных файлов
--     --         require("telescope").setup(opts)
--     --         -- подключаем расширение
--     --         require("telescope").load_extension("undo")
--     --     end,
--     -- },
-- }

return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		build = "make CMAKE_ARGS='-DCMAKE_POLICY_VERSION_MINIMUM=3.5'",
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
		-- tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			local insert_path_in_cmdline = function(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if selection then
					-- Assuming the full path is in selection.value.path or selection.absolute_path; based on docs, it's selection.Path for file_browser
					local full_path = selection.Path:string() -- Adjust based on entry structure (may be selection[1] or selection.absolute_path)
					vim.api.nvim_put({ full_path }, "c", true, true)
				end
			end

			local telescope_file_browser_in_cmdline = function()
				require("telescope").extensions.file_browser.file_browser({
					path = vim.fn.expand("%:p:h"),
					select_buffer = true,
					attach_mappings = function(_, map)
						map("i", "<CR>", insert_path_in_cmdline)
						map("n", "<CR>", insert_path_in_cmdline)
						return true
					end,
				})
			end

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
			-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Open file" })
			vim.keymap.set("n", "<leader>ff", function()
				local buf_path = vim.fn.expand("%:p:h")
				builtin.find_files({ cwd = buf_path })
			end, { desc = "Open file" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fine grep" })
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Old files" })
			-- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Change color scheme" })
			vim.keymap.set("n", "<leader>lsd", builtin.lsp_document_symbols, { desc = "Lsp Document's symbols" })
			vim.keymap.set("n", "<leader>lsw", builtin.lsp_workspace_symbols, { desc = "Lsp Workspase's symbols" })
			-- vim.keymap.set("n", "<leader>ma", builtin.marks, { desc = "Display marks" }d
			vim.keymap.set("n", "<leader>rg", builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Key maps" })
			vim.keymap.set(
				"n",
				"<leader>ds",
				builtin.lsp_document_symbols,
				{ desc = "Show all buffer lexical entities" }
			)
			-- vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "Key maps" })
			-- vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Key maps" })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rn",
				"<cmd>lua vim.lsp.buf.rename()<CR>",
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>fp", "<cmd>TelescopePath<CR>", { desc = "Key maps" })
			-- vim.api.nvim_set_keymap(
			-- "c",
			-- "<C-p>",
			-- '<Cmd>lua require("telescope.builtin").commands()<CR>',
			-- { noremap = true, silent = true }
			-- )
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("file_browser")
			vim.keymap.set("c", "<Tab>", telescope_file_browser_in_cmdline, { silent = true })
			-- vim.api.nvim_create_user_command("TelescopePath", function()
			-- vim.ui.input({ prompt = "Path: ", completion = "dir" }, function(path)
			-- if path then
			-- require("telescope.builtin").find_files({ cwd = path })
			-- end
			-- end)
			-- end, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	-- ~/.config/nvim/lua/plugins/telescope-undo.lua
	-- {
	-- "debugloop/telescope-undo.nvim",
	-- dependencies = {
	-- -- сам Telescope и его зависимость
	-- {
	-- "nvim-telescope/telescope.nvim",
	-- dependencies = { "nvim-lua/plenary.nvim" },
	-- },
	-- },
	-- -- Клавиша открытия undo-дерева (нормальный режим)
	-- keys = {
	-- { "<leader>u", "<cmd>Telescope undo<cr>", desc = "История undo" },
	-- },
	-- -- Опции – только то, что относится к расширению undo
	-- opts = {
	-- extensions = {
	-- undo = {
	-- -- Показывать дифы рядом (требует delta)
	-- side_by_side = true,
	-- -- Чуть больше места превью
	-- -- layout_strategy = "vertical",
	-- layout_config = {
	-- preview_height = 0.65,
	-- },
	-- -- Дополнительно: выводить только сохранённые состояния
	-- -- saved_only = true,
	-- },
	-- },
	-- },
	-- config = function(_, opts)
	-- -- объединяем конфиги Telescope из разных файлов
	-- require("telescope").setup(opts)
	-- -- подключаем расширение
	-- require("telescope").load_extension("undo")
	-- end,
	-- },
}
