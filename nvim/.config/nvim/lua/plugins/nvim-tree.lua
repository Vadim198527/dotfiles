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
                renderer = {
                    -- root_folder_label = ":~:s?$?/..?"
                    root_folder_label = false
                }
            })
            vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
        end,
    },
}
