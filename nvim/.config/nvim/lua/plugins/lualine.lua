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
                lualine_a = { "mode" },
            },
        })
    end,
}
