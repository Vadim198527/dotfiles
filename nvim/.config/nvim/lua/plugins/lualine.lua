return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                -- theme = 'dracula',
                theme = "auto",
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_c = {
                    "filename",
                },
                lualine_x = {
                    {
                        function()
                            -- Возвращаем 'РУС' если is_russian true, иначе 'ENG'
                            return _G.is_russian and "РУС" or "ENG"
                        end,
                        -- Можно добавить иконку
                        icon = "⌨ ", -- Опционально
                        -- Можно добавить цвет
                        color = { fg = "#98c379" }, -- Опционально
                    },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        })
    end,
}
