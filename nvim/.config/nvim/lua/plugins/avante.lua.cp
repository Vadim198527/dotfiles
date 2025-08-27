return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- add any opts here
		-- for example

		-- provider = "claude",
		-- claude = {
		-- 	endpoint = "https://api.anthropic.com",
		-- 	model = "claude-3-7-sonnet-latest",
		-- 	temperature = 0,
		-- 	max_tokens = 4096,
		-- },

		-- provider = "openrouter",
		-- vendors = {
		-- 	openrouter = {
		-- 		__inherited_from = "openai",
		-- 		endpoint = "https://openrouter.ai/api/v1",
		-- 		api_key_name = "OPENROUTER_API_KEY",
		-- 		-- model = "google/gemini-2.5-pro-preview-03-25",
		-- 		-- model = "openai/o3-mini-high",
		-- 		model = "openai/o4-mini-high",
		-- 	},
		-- },

		provider = "openai", -- Устанавливаем OpenAI как дефолтный провайдер
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1", -- Стандартный эндпоинт OpenAI
				-- model = "gpt-5-2025-08-07", -- Модель по умолчанию; можно изменить на gpt-4o, gpt-3.5-turbo и т.д.
				model = "gpt-5-mini-2025-08-07", -- Модель по умолчанию; можно изменить на gpt-4o, gpt-3.5-turbo и т.д.
                api_key = "OPENAI_API_KEY",
				timeout = 300000, -- Таймаут в миллисекундах (можно увеличить для сложных запросов)
				extra_request_body = {
					temperature = 1, -- Контролирует креативность (0 — детерминистично, 1 — креативно)
				},
			},
		},

		windows = {
			edit = {
				border = "rounded",
				start_insert = true, -- Start insert mode when opening the edit window
			},
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
				start_insert = false, -- Start insert mode when opening the ask window

				border = "rounded",
				---@type "ours" | "theirs"
				focus_on_apply = "ours", -- which diff to focus after applying
			},
		},
		file_selector = {
			provider = "telescope", -- Указываем telescope
			provider_opts = {
				-- !!! Убираем find_files отсюда !!!
				-- find_files = { ... }, -- Это, скорее всего, не работает так, как ожидалось

				-- !!! Вместо этого определяем get_filepaths !!!
				---@param params avante.file_selector.opts.IGetFilepathsParams
				get_filepaths = function(params)
					-- Используем cwd, переданный Avante, но с fallback на vim.fn.getcwd()
					local cwd = params.cwd
					if not cwd or cwd == "" or cwd == vim.fn.expand("~") then
						-- Если Avante не передал cwd или передал домашнюю директорию,
						-- принудительно используем текущую рабочую директорию Neovim
						cwd = vim.fn.getcwd()
						vim.notify(
							"[Avante] file_selector: params.cwd был невалидным ('"
								.. tostring(params.cwd)
								.. "'), используем vim.fn.getcwd(): "
								.. cwd,
							vim.log.levels.WARN
						)
					end

					local selected_filepaths = params.selected_filepaths or {} -- Файлы, уже выбранные в Avante

					-- Ваша команда поиска файлов (fd), но с явным указанием --base-directory
					-- Убедитесь, что параметры fd соответствуют вашим ожиданиям
					local cmd = string.format(
						"fd --base-directory '%s' --hidden --exclude .git --type f",
						vim.fn.fnameescape(cwd)
					)
					vim.notify(
						"[Avante] file_selector: Выполняем команду: " .. cmd,
						vim.log.levels.INFO
					) -- Для отладки

					-- Выполняем команду и получаем список файлов
					local output = vim.fn.system(cmd)

					-- Проверка на ошибки выполнения команды fd
					if vim.v.shell_error ~= 0 then
						vim.notify(
							"[Avante] file_selector: Ошибка выполнения fd: "
								.. cmd
								.. "\nКод ошибки: "
								.. vim.v.shell_error
								.. "\nВывод: "
								.. output,
							vim.log.levels.ERROR
						)
						return {} -- Возвращаем пустой список в случае ошибки
					end

					-- Разделяем вывод на строки, убираем пустые
					local filepaths = vim.split(output, "\n", { trimempty = true })

					-- Фильтруем уже выбранные файлы (если нужно)
					local filtered_filepaths = vim.iter(filepaths)
						:filter(function(filepath)
							return not vim.tbl_contains(selected_filepaths, filepath)
						end)
						:totable()

					vim.notify(
						"[Avante] file_selector: Найдено " .. #filtered_filepaths .. " файлов.",
						vim.log.levels.INFO
					) -- Для отладки
					return filtered_filepaths
				end,

				-- Здесь можно добавить опции, специфичные для *отображения* в Telescope,
				-- если Avante их поддерживает (но это менее вероятно, чем get_filepaths).
				-- Например, layout_config, но это нужно проверять в документации Avante или экспериментально.
			},
		},
		-- provider = "gemini",
		-- gemini = {
		-- 	endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
		-- 	model = "gemini-2.5-pro-exp-03-25",
		-- 	timeout = 100000, -- Timeout in milliseconds
		-- 	temperature = 1,
		-- 	max_tokens = 8192,
		-- },
		-- provider = "openai",
		-- openai = {
		--   endpoint = "https://api.openai.com/v1",
		--   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
		--   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
		--   temperature = 0,
		--   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
		--   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
		-- },
	},

	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { --[[ "markdown", ]]
					"Avante",
				},
			},
			ft = { --[[ "markdown", ]]
				"Avante",
			},
		},
	},

	-- config = function(_, opts)
	--     require("avante").setup(opts)
	--     -- Now define your custom keymaps HERE or in a separate keymaps file
	--     vim.keymap.set(
	--         "n",
	--         "<leader>aa",
	--         ":AvanteAsk position=right<CR>",
	--         { noremap = true, silent = true, desc = "Avante: Ask (right sidebar)" }
	--     )
	--     -- Add any other custom avante keymaps here...
	-- end,
}
