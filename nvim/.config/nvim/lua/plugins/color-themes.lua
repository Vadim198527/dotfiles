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
            -- vim.g.gruvbox_material_visual = "blue background"
            vim.g.gruvbox_material_foreground = "material"
            -- vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_gruvbox_material_enable_bold = true
            vim.g.gruvbox_material_visual = "green background"
            -- vim.g.gruvbox_material_visual = "reverse"
            -- vim.cmd.colorscheme("gruvbox-material")
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
                contrast = "hard", -- can be "hard", "soft" or empty string
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
        priority = 1000,
        config = function()
            local transparent = false -- set to true if you would like to enable transparency

            local bg = "#011628"
            local bg_dark = "#011423"
            local bg_highlight = "#143652"
            local bg_search = "#0A64AC"
            local bg_visual = "#275378"
            local fg = "#CBE0F0"
            local fg_dark = "#B4D0E9"
            local fg_gutter = "#627E97"
            local border = "#547998"

            require("tokyonight").setup({
                style = "night",
                transparent = transparent,
                styles = {
                    sidebars = transparent and "transparent" or "dark",
                    floats = transparent and "transparent" or "dark",
                },
                on_colors = function(colors)
                    colors.bg = bg
                    colors.bg_dark = transparent and colors.none or bg_dark
                    colors.bg_float = transparent and colors.none or bg_dark
                    colors.bg_highlight = bg_highlight
                    colors.bg_popup = bg_dark
                    colors.bg_search = bg_search
                    colors.bg_sidebar = transparent and colors.none or bg_dark
                    colors.bg_statusline = transparent and colors.none or bg_dark
                    colors.bg_visual = bg_visual
                    colors.border = border
                    colors.fg = fg
                    colors.fg_dark = fg_dark
                    colors.fg_float = fg
                    colors.fg_gutter = fg_gutter
                    colors.fg_sidebar = fg_dark
                end,
            })

            -- vim.cmd("colorscheme tokyonight")
        end,
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
    { "rose-pine/neovim",             name = "rose-pine" },
    { "miikanissi/modus-themes.nvim", priority = 1000 },
    {
        "morhetz/gruvbox",
        config = function()
            vim.g.gruvbox_contrast_dark = "soft"
        end,
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "uloco/bluloco.nvim",
        lazy = false,
        priority = 1000,
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            -- your optional config goes here, see below.
        end,
    },
}
