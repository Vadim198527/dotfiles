return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin-mocha")
            -- vim.cmd.colorscheme("catppuccin-latte")
        end,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_visual = "blue background"
            -- vim.g.gruvbox_material_enable_bold = 1
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            -- vim.g.gruvbox_material_enable_italic = true
            -- vim.g.gruvbox_material_transparent_background = 0
            -- vim.cmd.colorscheme("gruvbox-material")
            -- Переопределите цвет выделения
            -- vim.api.nvim_set_hl(0, "Visual", { bg = "#5f87af", fg = "NONE" })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        name = "gruvbox",
        priority = 1000,
        config = function()
            -- Default options:
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            -- vim.cmd("colorscheme gruvbox")
            -- vim.cmd.colorscheme "gruvbox"
            -- vim.cmd.colorscheme("gruvbox-latte")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "sainnhe/everforest",
    },
    { "EdenEast/nightfox.nvim" },
    {
        "maxmx03/solarized.nvim",
        lazy = false,
        priority = 1000,
        ---@type solarized.config
        opts = {},
        config = function(_, opts)
            require("solarized").setup(opts)
        end,
    },
}
