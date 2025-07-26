return {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    keys = {
        {
            "<leader>f*",
            function()
                require("grug-far").open({
                    prefills = { search = vim.fn.expand("<cword>") },
                })
            end,
            mode = { "n" },
            desc = "Grug-Far: Search for word under cursor",
        },
        -- {
        --     "<leader>f*",
        --     function()
        --         require('grug-far').open({
        --             prefills = { search = vim.fn.expand("<cword>") }
        --         })
        --     end
        --     mode = { "n" },
        --     desc = "Grug-Far: Search for word under cursor",
        -- },
    },
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require("grug-far").setup({
            windowCreationCommand = "botright vsplit",
            enabledEngines = { "ripgrep", "astgrep" },
            -- options, see Configuration section below
            -- there are no required options atm
        })
    end,
}
