return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Open file" })
            vim.keymap.set("n", "<leader>.", builtin.find_files, { desc = "Open file" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fine grep" })
            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Old files" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Change color scheme" })
            vim.keymap.set("n", "<leader>ma", builtin.marks, { desc = "Display marks" })
            vim.keymap.set("n", "<leader>rg", builtin.registers, { desc = "Registers" })
            vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Key maps" })
            vim.keymap.set(
                "n",
                "<leader>ds",
                builtin.lsp_document_symbols,
                { desc = "Show all buffer lexical entities" }
            )
            vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "Key maps" })
            vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap=true, silent=true })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
