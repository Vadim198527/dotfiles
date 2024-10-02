return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            enable_check_bracket_line = false, -- Позволяет выходить за скобки в любой позиции строки
            ignored_next_char = "[%w%.]", -- Игнорирует буквенно-цифровые символы
            enable_moveright = true,  -- Автоматически перемещаться за закрывающую скобку
            disable_filetype = { "TelescopePrompt", "tex" },
        })
        -- -- Инициализация nvim-cmp
        -- local cmp = require("cmp")
        -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        --
        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        --
        -- cmp.setup({
        --     -- Ваша существующая конфигурация cmp
        -- })
    end,
}
