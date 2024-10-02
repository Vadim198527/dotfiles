return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Your textobject-related config here
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Автоматический переход к следующему совпадению
                        keymaps = {
                            ["af"] = "@call.outer", -- Выделение вызова функции целиком
                            ["if"] = "@call.inner", -- Выделение внутренней части вызова функции
                            ["aF"] = "@function.outer", -- Выделение определения функции целиком
                            ["iF"] = "@function.inner", -- Выделение тела функции
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "python", "latex" },
                -- ignore_install = { "latex" },
                highlight = {
                    enable = true,
                    disable = { "latex" },
                },
                indent = { enable = true },
            })
        end,
    },
}
