return {
    -- { "rafamadriz/friendly-snippets" },
    -- { "saadparwaiz1/cmp_luasnip" },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            -- Подключаем LuaSnip и загружаем сниппеты
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/config/snippets" })
            require("luasnip").config.setup({
                enable_autosnippets = true,
                update_events = "TextChanged,TextChangedI",
            })
            require("luasnip").config.set_config({ -- Setting LuaSnip config
                -- Use <Tab> (or some other key if you prefer) to trigger visual selection
                store_selection_keys = "<Tab>",
                update_events = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })
            --         vim.cmd([[
            -- " Use Tab to expand and jump through snippets
            -- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
            -- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
            --
            -- " Use Shift-Tab to jump backwards through snippets
            -- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
            -- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
            -- ]])
        end,
    },
}
