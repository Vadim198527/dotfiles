return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ts_ls", "texlab", "ltex" }, -- "ltex", "texlab"
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.ts_ls.setup({ capabilities = capabilities })
            -- lspconfig.ltex.setup({ capabilities = capabilities })
            -- lspconfig.texlab.setup({ capabilities = capabilities })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.api.nvim_create_user_command("DisableDiagnostics", function()
                vim.diagnostic.config({
                    virtual_text = false,
                    signs = false,
                    underline = false,
                })
            end, {})
            vim.api.nvim_create_user_command("EnableDiagnostics", function()
                vim.diagnostic.config({
                    virtual_text = true,
                    signs = true,
                    underline = true,
                })
            end, {})
            -- Привязка клавиши для отключения диагностик
            vim.api.nvim_set_keymap("n", "<leader>dd", ":DisableDiagnostics<CR>", { noremap = true })
            -- Привязка клавиши для включения диагностик
            vim.api.nvim_set_keymap("n", "<leader>de", ":EnableDiagnostics<CR>", { noremap = true })
        end,
    },
}
