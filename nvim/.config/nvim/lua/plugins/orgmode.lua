return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
        -- Setup orgmode
        require("orgmode").setup({
            org_agenda_files = "~/docs/**/*",
            -- org_default_notes_file = "~/orgfiles/refile.org",
            -- mappings = {
            --     org = {
            --         org_meta_return = 'zx'
            --     }
            -- }
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'org',
                callback = function()
                    vim.keymap.set('i', '<C-y>', '<C-o>:lua require("orgmode").action("org_mappings.meta_return")<CR>', {
                        -- silent = true,
                        buffer = true,
                    })
                end,
            })
        })
        -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
        -- add ~org~ to ignore_install
        -- require('nvim-treesitter.configs').setup({
        --   ensure_installed = 'all',
        -- })
    end,
}
