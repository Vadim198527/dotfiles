return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal_cmd = "/Users/chestnykh/.claude/local/claude", -- Ваш путь
		port_range = { min = 8000, max = 8100 }, -- Исправленный формат: с ключами min и max
		auto_start = true,
		log_level = "info",
	},
	config = true,
	keys = { -- Ключевые привязки
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil" },
		},
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}

-- return {
-- 	"greggh/claude-code.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim", -- Required for git operations
-- 	},
-- 	config = function()
--         vim.opt.splitright = true
--         
-- 		require("claude-code").setup({
-- 			-- Terminal window settings
-- 			window = {
-- 				split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
-- 				position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
-- 				enter_insert = true, -- Whether to enter insert mode when opening Claude Code
-- 				hide_numbers = true, -- Hide line numbers in the terminal window
-- 				hide_signcolumn = true, -- Hide the sign column in the terminal window
--
-- 				-- Floating window configuration (only applies when position = "float")
-- 				float = {
-- 					width = "80%", -- Width: number of columns or percentage string
-- 					height = "80%", -- Height: number of rows or percentage string
-- 					row = "center", -- Row position: number, "center", or percentage string
-- 					col = "center", -- Column position: number, "center", or percentage string
-- 					relative = "editor", -- Relative to: "editor" or "cursor"
-- 					border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
-- 				},
-- 			},
-- 			-- File refresh settings
-- 			refresh = {
-- 				enable = true, -- Enable file change detection
-- 				updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
-- 				timer_interval = 1000, -- How often to check for file changes (milliseconds)
-- 				show_notifications = true, -- Show notification when files are reloaded
-- 			},
-- 			-- Git project settings
-- 			git = {
-- 				use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
-- 			},
-- 			-- Shell-specific settings
-- 			shell = {
-- 				separator = "&&", -- Command separator used in shell commands
-- 				pushd_cmd = "pushd", -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
-- 				popd_cmd = "popd", -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
-- 			},
-- 			-- Command settings
-- 			command = "claude", -- Command used to launch Claude Code
-- 			-- Command variants
-- 			command_variants = {
-- 				-- Conversation management
-- 				continue = "--continue", -- Resume the most recent conversation
-- 				resume = "--resume", -- Display an interactive conversation picker
--
-- 				-- Output options
-- 				verbose = "--verbose", -- Enable verbose logging with full turn-by-turn output
-- 			},
-- 			-- Keymaps
-- 			keymaps = {
-- 				toggle = {
-- 					normal = "<C-,>", -- Normal mode keymap for toggling Claude Code, false to disable
-- 					terminal = "<C-,>", -- Terminal mode keymap for toggling Claude Code, false to disable
-- 					variants = {
-- 						continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
-- 						verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
-- 					},
-- 				},
-- 				window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
-- 				scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
-- 			},
-- 		})
-- 	end,
-- }
