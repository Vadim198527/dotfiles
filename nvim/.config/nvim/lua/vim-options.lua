vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ortur
-- vim.opt.wrap = true
-- vim.opt.wrapmargin = 15
vim.o.timeout = true
vim.o.timeoutlen = 6000
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.tabstop = 4
vim.cmd("set softtabstop=2")
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
-- Display line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Smart tab behavior
vim.opt.smarttab = true
-- Enable mouse support
vim.opt.mouse = "a"
-- Set encoding to UTF-8
vim.opt.encoding = "utf-8"
-- Disable Vi compatibility mode
vim.opt.compatible = false
vim.cmd('set clipboard+=unnamedplus')
-- Highlight the current line
-- vim.opt.cursorline = true

-- Disable preview window in completion
vim.opt.completeopt:remove("preview")


vim.api.nvim_set_keymap("n", "<C-i>", "zz", { noremap = true })
-- Перемещение текущей строки в центр экрана при нажатии Ctrl + l в режиме вставки
vim.api.nvim_set_keymap("i", "<C-i>", "<C-o>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-e>", "$", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w/", ":vsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ww", ":wincmd w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w-", ":split<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>wd", ":close<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":close<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true })
-- Навигация между окнами с помощью Ctrl + h/j/k/l
-- vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_set_keymap(
            "n",
            "<F9>",
            ":w<CR>:botright 10split | terminal python3 %<CR>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            "i",
            "<F9>",
            ":w<CR>:botright 10split | terminal python3 %<CR>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>rc",
            ":w<CR>:!python3 %<CR>",
            { noremap = true, silent = true }
        )
    end,
})


-- Глобальная переменная для отслеживания состояния раскладки
_G.is_russian = false

-- Функция для переключения раскладки
function _G.toggle_keymap()
    if _G.is_russian then
        vim.o.keymap = ""
        _G.is_russian = false
        print("Раскладка: Английская")
    else
        vim.o.keymap = "russian-jcukenwin"
        _G.is_russian = true
        print("Раскладка: Русская")
    end
end

-- Настройка сочетаний клавиш
vim.api.nvim_set_keymap("n", "<C-Space>", ":lua toggle_keymap()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Space>", "<C-o>:lua toggle_keymap()<CR>", { noremap = true, silent = true })

-- -- Функция для умного поведения клавиши Tab
-- function _G.smart_tab()
--     local luasnip = require("luasnip")
--     -- Проверяем, открыто ли меню автодополнения (если используете, например, nvim-cmp)
--     if vim.fn.pumvisible() == 1 then
--         return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
--         -- Проверяем, может ли LuaSnip расширить сниппет или перейти к следующей позиции
--     elseif luasnip.expand_or_jumpable() then
--         return vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true)
--     else
--         local col = vim.fn.col(".")
--         local line = vim.fn.getline(".")
--         local next_char = line:sub(col, col)
--         -- Проверяем, является ли следующий символ закрывающей скобкой или кавычкой
--         if next_char:match("[%]%)}'\"]") then
--             return vim.api.nvim_replace_termcodes("<Right>", true, true, true)
--         else
--             -- Вставляем символ табуляции или выполняем отступ
--             return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
--         end
--     end
-- end

function _G.smart_tab()
    local luasnip = require("luasnip")
    local col = vim.fn.col(".") - 1

    -- Проверяем, открыто ли меню автодополнения
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)

        -- 1. Если можно развернуть сниппет
    elseif luasnip.expandable() then
        return vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-snippet", true, true, true)
    else
        local line = vim.fn.getline(".")
        local next_char = line:sub(col + 1, col + 1)

        -- 2. Если следующий символ закрывающий
        if next_char:match("[%]%)}'\"]") then
            return vim.api.nvim_replace_termcodes("<Right>", true, true, true)

            -- 3. Если можно перейти к следующей позиции в сниппете
        elseif luasnip.jumpable(1) then
            return vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, true, true)
        else
            -- 4. Вставляем символ табуляции или выполняем отступ
            if col == 0 or line:sub(1, col):match("^%s*$") then
                -- В начале строки или после пробелов — выполняем отступ
                return vim.api.nvim_replace_termcodes("<Esc>^i<Tab>", true, true, true)
            else
                -- Вставляем символ табуляции или пробелы
                return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
            end
        end
    end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })

vim.api.nvim_set_keymap('i', '<Plug>luasnip-expand-snippet', '<cmd>lua require("luasnip").expand()<CR>', { silent = true })
vim.api.nvim_set_keymap('i', '<Plug>luasnip-jump-next', '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })


-- Назначаем клавишу Tab в режиме вставки
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.smart_tab()", { expr = true, noremap = true, silent = true })
-- Создаем синоним клавиши Tab
vim.api.nvim_set_keymap("i", "<C-f>", "    ", { noremap = true, silent = true })

-- Функция для умного поведения Shift-Tab (переход к предыдущей позиции в LuaSnip)
function _G.smart_s_tab()
    local luasnip = require("luasnip")
    if luasnip.jumpable(-1) then
        return vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true)
    else
        return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
    end
end

-- Назначаем клавишу Shift-Tab в режиме вставки
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.smart_s_tab()", { expr = true, noremap = true, silent = true })

-- Отмена последнего действия при нажатии Ctrl + / в режиме вставки
vim.api.nvim_set_keymap("i", "<C-/>", "<C-o>u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-r>", "<C-o><C-r>", { noremap = true, silent = true })

-- Меняем текущую дирректорию
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("silent! lcd %:p:h")
    end,
})
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- vim.cmd("map <leader>q :q<CR>")
vim.cmd("map e ea")
