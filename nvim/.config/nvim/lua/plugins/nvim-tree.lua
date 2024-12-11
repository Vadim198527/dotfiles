return {
    {
        "ryanoasis/vim-devicons",
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                -- -- Синхронизирует корневую директорию nvim-tree с текущей рабочей директорией Neovim
                -- sync_root_with_cwd = true,
                --
                -- -- Заставляет nvim-tree учитывать директорию текущего буфера
                -- respect_buf_cwd = true,

                update_focused_file = {
                    -- Включает автоматическое обновление выделенного файла при переключении буферов
                    enable = true,

                    -- Настройки для обновления корневой директории
                    update_root = {
                        -- Включает обновление корневой директории при переключении файлов
                        enable = true,

                        -- Список буферов или типов файлов, которые следует игнорировать при обновлении корня
                        ignore_list = {},
                    },
                },
                renderer = {
                    root_folder_label = false,
                },
            })

            vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
            -- vim.keymap.del('n', '<C-W>d')
            -- vim.keymap.del('n', '<C-W><C-d>')
            -- vim.api.nvim_set_keymap("n", "<C-W>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
        end,
    },
}
