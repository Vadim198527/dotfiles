-- ~/.config/nvim/lua/plugins/yankassassin.lua
return {
	dir = vim.fn.stdpath("config") .. "/lua/yankassassin",
	name = "yankassassin",
	event = "VimEnter",
	config = function()
		require("yankassassin").setup({
			-- auto_normal = true: Автоматически применять логику "не перемещать курсор"
			-- для стандартной команды 'y' в нормальном режиме.
			-- Если false, стандартный 'y' будет работать как обычно,
			-- и вам нужно будет использовать <Plug>(YANoMove) (например, через <leader>y).
			auto_normal = true,

			-- auto_visual = true: То же самое, но для визуального режима.
			auto_visual = true,
		})

		-- == Опциональные пользовательские маппинги ==
		-- Если вы хотите иметь *и* стандартное поведение, *и* поведение без перемещения,
		-- вы можете настроить маппинги.

		-- Пример:
		-- gy -> стандартное поведение (курсор перемещается)
		vim.keymap.set(
			{ "n", "x", "v" },
			"gy",
			"<Plug>(YADefault)",
			{ silent = true, desc = "Yank (Default behavior)" }
		)

		-- -- <leader>y -> поведение без перемещения курсора
		-- vim.keymap.set(
		-- 	{ "n", "x", "v" },
		-- 	"<leader>y",
		-- 	"<Plug>(YANoMove)",
		-- 	{ silent = true, desc = "Yank (Don't move cursor)" }
		-- )

		-- Если auto_normal = true и auto_visual = true, то стандартные 'y' и 'Y'
		-- УЖЕ будут вести себя как <Plug>(YANoMove) (т.е. не перемещать курсор),
		-- кроме как в буферах nvim-tree, где они будут вести себя как обычно.
		-- В этом случае маппинг <leader>y выше становится избыточным,
		-- но маппинг 'gy' все еще полезен, если вам иногда нужно стандартное поведение.
	end,
}
