return {
	{
		"guns/vim-sexp",
		lazy = false,
		dependencies = {
			-- "tpope/vim-sexp-mappings-for-regular-people",
			"tpope/vim-repeat",
			-- "tpope/vim-surround",
		},
		ft = { "clojure", "scheme", "lisp", "racket" },
		config = function()
			-- Включаем для нужных файлов
			vim.g.sexp_filetypes = "clojure,scheme,lisp,racket"
			-- Настройка маппингов
			local function sexp_maps()
				for _, mode in ipairs({ "x", "o" }) do
					-- Формы
					vim.keymap.set(mode, "af", "<Plug>(sexp_outer_list)", { buffer = true })
					vim.keymap.set(mode, "if", "<Plug>(sexp_inner_list)", { buffer = true })
					vim.keymap.set(mode, "aF", "<Plug>(sexp_outer_top_list)", { buffer = true })
					vim.keymap.set(mode, "iF", "<Plug>(sexp_inner_top_list)", { buffer = true })
					-- Строки
					-- vim.keymap.set(mode, "as", "<Plug>(sexp_outer_string)", { buffer = true })
					-- vim.keymap.set(mode, "is", "<Plug>(sexp_inner_string)", { buffer = true })
					-- Элементы
					vim.keymap.set(mode, "ae", "<Plug>(sexp_outer_element)", { buffer = true })
					vim.keymap.set(mode, "ie", "<Plug>(sexp_inner_element)", { buffer = true })
				end

				-- Движение по формам (normal, visual, operator)
				for _, mode in ipairs({ "n", "x", "o" }) do
					-- По скобкам
					-- vim.keymap.set(mode, "(", "<Plug>(sexp_move_to_prev_bracket)", { buffer = true })
					-- vim.keymap.set(mode, ")", "<Plug>(sexp_move_to_next_bracket)", { buffer = true })
					-- По элементам
					vim.keymap.set(mode, "B", "<Plug>(sexp_move_to_prev_element_head)", { buffer = true })
					vim.keymap.set(mode, "W", "<Plug>(sexp_move_to_next_element_head)", { buffer = true })
					-- vim.keymap.set(mode, "gE", "<Plug>(sexp_move_to_prev_element_tail)", { buffer = true })
					-- vim.keymap.set(mode, "E", "<Plug>(sexp_move_to_next_element_tail)", { buffer = true })
					-- По верхнеуровневым элементам
					vim.keymap.set(mode, "[[", "<Plug>(sexp_move_to_prev_top_element)", { buffer = true })
					vim.keymap.set(mode, "]]", "<Plug>(sexp_move_to_next_top_element)", { buffer = true })
				end

				-- Flow commands (normal, visual)
				for _, mode in ipairs({ "n", "x" }) do
					vim.keymap.set(mode, "(", "<Plug>(sexp_flow_to_prev_open)", { buffer = true })
					vim.keymap.set(mode, ")", "<Plug>(sexp_flow_to_next_close)", { buffer = true })
					vim.keymap.set(mode, "<C-0>", "<Plug>(sexp_flow_to_prev_close)", { buffer = true })
					vim.keymap.set(mode, "<C-9>", "<Plug>(sexp_flow_to_next_open)", { buffer = true })
					vim.keymap.set(mode, "<M-0>", "<Plug>(sexp_flow_to_prev_close)", { buffer = true })
					vim.keymap.set(mode, "<M-9>", "<Plug>(sexp_flow_to_next_open)", { buffer = true })
					-- vim.keymap.set(mode, "<M-{>", "<Plug>(sexp_flow_to_prev_open)", { buffer = true })
					-- vim.keymap.set(mode, "<>", "<Plug>(sexp_flow_to_prev_close)", { buffer = true })
					-- vim.keymap.set(mode, "<leader>(", "<Plug>(sexp_round_head_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "B", "<Plug>(sexp_flow_to_prev_leaf_head)", { buffer = true })
					vim.keymap.set(mode, "W", "<Plug>(sexp_flow_to_next_leaf_head)", { buffer = true })
					-- vim.keymap.set(mode, "<localleader>e", "<Plug>(sexp_flow_to_prev_leaf_tail)", { buffer = true })
					vim.keymap.set(mode, "E", "<Plug>(sexp_flow_to_next_leaf_tail)", { buffer = true })

					vim.keymap.set(mode, "<leader>(", "<Plug>(sexp_round_head_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "<leader>)", "<Plug>(sexp_round_tail_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "<leader>[", "<Plug>(sexp_square_head_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "<leader>]", "<Plug>(sexp_square_tail_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "<leader>{", "<Plug>(sexp_curly_head_wrap_list)", { buffer = true })
					vim.keymap.set(mode, "<leader>}", "<Plug>(sexp_curly_tail_wrap_list)", { buffer = true })

					vim.keymap.set(mode, "<leader>e(", "<Plug>(sexp_round_head_wrap_element)", { buffer = true })
					vim.keymap.set(mode, "<leader>e)", "<Plug>(sexp_round_tail_wrap_element)", { buffer = true })
					vim.keymap.set(mode, "<leader>e[", "<Plug>(sexp_square_head_wrap_element)", { buffer = true })
					vim.keymap.set(mode, "<leader>e]", "<Plug>(sexp_square_tail_wrap_element)", { buffer = true })
					vim.keymap.set(mode, "<leader>e{", "<Plug>(sexp_curly_head_wrap_element)", { buffer = true })
					vim.keymap.set(mode, "<leader>e}", "<Plug>(sexp_curly_tail_wrap_element)", { buffer = true })
				end

				-- Манипуляции с формами
				for _, mode in ipairs({ "n", "x" }) do
					-- Swap commands
					vim.keymap.set(mode, "<f", "<Plug>(sexp_swap_list_backward)", { buffer = true })
					vim.keymap.set(mode, ">f", "<Plug>(sexp_swap_list_forward)", { buffer = true })
					vim.keymap.set(mode, "<e", "<Plug>(sexp_swap_element_backward)", { buffer = true })
					vim.keymap.set(mode, ">e", "<Plug>(sexp_swap_element_forward)", { buffer = true })

					-- Emit/Capture
					vim.keymap.set(mode, "<(", "<Plug>(sexp_emit_head_element)", { buffer = true })
					vim.keymap.set(mode, ">)", "<Plug>(sexp_emit_tail_element)", { buffer = true })
					vim.keymap.set(mode, ">(", "<Plug>(sexp_capture_prev_element)", { buffer = true })
					vim.keymap.set(mode, "<)", "<Plug>(sexp_capture_next_element)", { buffer = true })
				end
				vim.keymap.set("n", "<Localleader>(", "<Plug>(sexp_insert_at_list_head)", { buffer = true })
				vim.keymap.set("n", "<Localleader>)", "<Plug>(sexp_insert_at_list_tail)", { buffer = true })

				-- Insert mode mappings
				local insert_mappings = {
					["("] = "sexp_insert_opening_round",
					[")"] = "sexp_insert_closing_round",
					["["] = "sexp_insert_opening_square",
					["]"] = "sexp_insert_closing_square",
					["{"] = "sexp_insert_opening_curly",
					["}"] = "sexp_insert_closing_curly",
					['"'] = "sexp_insert_double_quote",
					["<BS>"] = "sexp_insert_backspace",
					["<C-h>"] = "sexp_insert_backspace",
				}

				for key, plug in pairs(insert_mappings) do
					vim.keymap.set("i", key, string.format("<Plug>(%s)", plug), { buffer = true })
				end

				-- Дополнительные маппинги для работы с формами
				vim.keymap.set("n", "==", "<Plug>(sexp_indent)", { buffer = true })
				vim.keymap.set("n", "=-", "<Plug>(sexp_indent_top)", { buffer = true })
				vim.keymap.set("n", "<leader>@", "<plug>(sexp_splice_list)", { buffer = true })
				vim.keymap.set("n", "<leader>?", "<Plug>(sexp_convolute)", { buffer = true })
				vim.keymap.set("n", "<leader>rf", "<Plug>(sexp_raise_list)", { buffer = true })
				vim.keymap.set("n", "<leader>re", "<Plug>(sexp_raise_element)", { buffer = true })
			end

			-- Автоматически применяем маппинги для нужных типов файлов
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "clojure", "scheme", "lisp", "racket"},
				callback = sexp_maps,
			})
		end,
	},
}
