return {
    {
        "echasnovski/mini.nvim",
        version = false,
        lazy = false,
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                custom_textobjects = {
                    F = ai.gen_spec.treesitter({a = '@function.outer', i = '@function.inner'})
                },
            })
            -- require("mini.surround").setup({
            --     custom_surroundings = nil,
            --     mappings = {
            --         add = "ys",
            --         delete = "ds",
            --         find = "",
            --         find_left = "",
            --         highlight = "",
            --         replace = "cs",
            --         update_n_lines = "",
            --
            --         -- Add this only if you don't want to use extended mappings
            --         suffix_last = "l",
            --         suffix_next = "n",
            --     },
            -- })
            require("mini.operators").setup({})
            -- require("mini.pairs").setup()
            -- local map_bs = function(lhs, rhs)
            --     vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
            -- end
            --
            -- map_bs("<C-h>", "v:lua.MiniPairs.bs()")
            -- map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
            -- map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')
            -- -- Отключаем атодополнение ' для .rkt файлов
            -- vim.api.nvim_create_autocmd("FileType", {
            --     pattern = "racket",
            --     callback = function()
            --         -- Unmap the ' key in the current buffer and unregister its pairing
            --         require("mini.pairs").unmap_buf(0, "i", "'", "''")
            --     end,
            -- })

            -- require("mini.indentscope").setup()
            require("mini.icons").setup()
            require("mini.files").setup()
            -- require("mini.jump2d").setup({
            --     mappings = {
            --         start_jumping = "<C-_>",
            --     },
            -- })
            require("mini.animate").setup({
                scroll = {
                    timing = require("mini.animate").gen_timing.linear({ duration = 125, unit = "total" }),
                },
                cursor = {
                    enable = false,
                },
            })
            -- require("mini.pairs").setup({})
            -- one two three (7)
        end,
    },
}
