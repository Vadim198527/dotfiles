return {
	"Olical/conjure",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = { "scheme", "racket" },
	config = function()
	    -- Создаем автокоманду для Racket файлов
	    vim.api.nvim_create_autocmd("FileType", {
	        pattern = "racket",
	        callback = function()
	            -- Создаем маппинг <leader>rs для остановки Conjure REPL
	            vim.keymap.set("n", "<leader>rs", ":ConjureRktStop<CR>", {
	                buffer = true, -- Маппинг только для текущего буфера
	                silent = true, -- Не показывать команду в командной строке
	                noremap = true, -- Не использовать рекурсивный маппинг
	                desc = "Stop Racket REPL", -- Описание команды для which-key
	            })
	            vim.keymap.set("n", "<leader>rr", ":ConjureRktStart<CR>", {
	                buffer = true, -- Маппинг только для текущего буфера
	                silent = true, -- Не показывать команду в командной строке
	                noremap = true, -- Не использовать рекурсивный маппинг
	                desc = "Start Racket REPL", -- Описание команды для which-key
	            })
	            vim.keymap.set("n", "<leader>rc", ":ConjureEvalBuf<CR>", {
	                buffer = true, -- Маппинг только для текущего буфера
	                silent = true, -- Не показывать команду в командной строке
	                noremap = true, -- Не использовать рекурсивный маппинг
	                desc = "Eval Buffer", -- Описание команды для which-key
	            })
	        end,
	    })
	end,
}
