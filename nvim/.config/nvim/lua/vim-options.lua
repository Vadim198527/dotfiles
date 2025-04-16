local keymap = vim.keymap.set

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.timeout = true
-- sldkfj

vim.o.timeoutlen = 6000
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.compatible = false
vim.opt.ignorecase = true -- Игнорировать регистр при поиске
vim.opt.smartcase = true
-- vim.opt.clipboard = "unnamedplus"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.softtabstop = 4
vim.opt.autochdir = true
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

vim.cmd([[
set undofile
set undodir=~/.config/nvim/undo
set undolevels=400
]])

vim.cmd([[
	let g:python_indent = {}
	let g:python_indent.disable_parentheses_indenting = v:false
	let g:python_indent.closed_paren_align_last_line = v:false
	let g:python_indent.searchpair_timeout = 150
	let g:python_indent.continue = 'shiftwidth()'
	let g:python_indent.open_paren = 'shiftwidth()'
	let g:python_indent.nested_paren = 'shiftwidth()'
]])

-- Добавьте это в init.lua
vim.filetype.add({
    extension = {
        rkt = "racket",
    },
})
-- Делаем так, чтобы нажатие o не создавало строку с комментарием
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove("o")
    end,
})

-- vim.opt.formatoptions:remove('o')
vim.cmd(":syntax enable")
vim.cmd(":syntax on")
vim.cmd(":set foldmethod=indent")
vim.cmd(":set foldcolumn=0")
vim.cmd(":set foldlevel=99")
-- Highlight the current line
vim.opt.cursorline = true
vim.o.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal"
-- Disable preview window in comple
vim.opt.completeopt:remove("preview")
keymap("v", "<leader>dl", '"_d', { noremap = true, silent = true })
-- keymap("n", "<C-c>", '"+y', { noremap = true, silent = true })
-- keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
-- keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
-- keymap("v", "<C-v>", '"+p', { noremap = true, silent = true })
keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })

keymap("n", "<leader>ch", ":AvanteClear<cr>", { noremap = true, silent = true })

keymap("n", "<F5>", function()
    vim.cmd("normal! zz")
    vim.cmd("normal! 6")
end, { noremap = true })
keymap("i", "<F5>", function()
    vim.cmd("normal! zz")
    vim.cmd("normal! 6")
end, { noremap = true })
keymap("n", "<C-p>", "o<Left><Right><Esc>", { noremap = true })
-- keymap("i", "\27[28;6;39~", "<C-o>zz", { noremap = true, silent = true })
keymap("n", "<C-a>", "^", { noremap = true, silent = true })
keymap("n", "<C-e>", "$", { noremap = true })
keymap("n", "<leader>w/", ":vsplit<CR>", { noremap = true })
keymap("n", "<leader>ww", ":wincmd w<CR>", { noremap = true, silent = true })
keymap("n", "<leader>w-", ":split<CR>", { noremap = true })
keymap("n", "<leader>wd", ":close<CR>", { noremap = true })
keymap("n", "<leader>x", ":close<CR>", { noremap = true })
keymap("n", "<leader>w1", ":only<CR>", { noremap = true })
keymap("i", "<C-a>", "<esc>I", { noremap = true })
keymap("i", "<C-e>", "<esc>A", { noremap = true })
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-e>", "<End>", { noremap = true })
--
keymap("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true })
keymap("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true })

keymap("v", "<D-c>", '"+y', { noremap = true, silent = true })
keymap("x", "y", "y`>", { silent = true })
-- keymap("v", "J", ":m '>+1<CR>gv=gv")
-- keymap("v", "K", ":m '>-2<CR>Pgv=gv")
-- vim.cmd(':xnoremap <leader>p "_dP')
vim.cmd(":autocmd BufWritePre *.vim :normal gg=G``")
vim.cmd([[autocmd TermOpen * startinsert | terminal]])

keymap("n", "<C-.>", "<C-a>")
keymap("n", "<C-,>", "<C-x>")

function RunCode()
    -- Сохраняем текущий файл
    vim.cmd("w")
    -- Получаем тип файла
    local filetype = vim.bo.filetype

    -- Таблица соответствий типов файлов и команд для запуска
    local run_cmds = {
        python = "!python3 %",
        lua = "!lua %",
        -- Вы можете добавить другие языки по необходимости
        javascript = "!node %",
        -- c = "botright 15split | terminal gcc -o a.out % && ./a.out",
    }

    -- Получаем команду для текущего типа файла
    local cmd = run_cmds[filetype]

    if cmd then
        -- Выполняем команду
        vim.cmd(cmd)
    else
        -- Выводим сообщение, если тип файла не поддерживается
        print("Невозможно выполнить этот тип файла: " .. filetype)
    end
end

keymap("n", "<leader>rc", ":lua RunCode()<CR>", { noremap = true, silent = true })
local function olan()
    vim.cmd("write")
    local bufList = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufList) do
        local bufName = vim.api.nvim_buf_get_name(buf)
        if string.match(bufName, "^term://") ~= nil then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    -- vim.cmd("botright 15split | terminal gcc -o a.out % && ./a.out")
    vim.cmd(
        "silent !tmux send-keys -t .1 'clear && gcc -o a.out "
        .. vim.fn.expand("%")
        .. " && ./a.out' C-m && tmux select-pane -t .1"
    )
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        vim.keymap.set("n", "<leader>rc", olan, { buffer = true })
    end,
})
-- Глобальная переменная для отслеживания состояния раскладки
_G.is_russian = false

-- Функция для переключения раскладки
function _G.toggle_keymap()
    if _G.is_russian then
        vim.o.keymap = ""
        _G.is_russian = false
    else
        vim.o.keymap = "russian-jcukenwin"
        _G.is_russian = true
    end
end

-- Настройка сочетаний клавиш
keymap("n", "<C-Space>", ":lua toggle_keymap()<CR>", { noremap = true, silent = true })
keymap("i", "<C-Space>", "<C-o>:lua toggle_keymap()<CR>", { noremap = true, silent = true })

keymap("i", "<Plug>luasnip-expand-snippet", '<cmd>lua require("luasnip").expand()<CR>', { silent = true })
keymap("i", "<Plug>luasnip-jump-next", '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })

-- keymap("i", "<C-f>", "<Tab>", { noremap = true, silent = true })
keymap("i", "<C-l>", "<Tab>", { noremap = true, silent = true })

-- Отмена последнего действия при нажатии Ctrl + / в режиме вставки
keymap("i", "<C-/>", "<C-o>u", { noremap = true, silent = true })
-- keymap("i", "<C-r>", "<C-o><C-r>", { noremap = true, silent = true })

keymap("n", "<leader>h", ":nohlsearch<CR>")
vim.opt.hlsearch = false
-- resize window
keymap("n", "_", ":resize -1<CR>")
keymap("n", "+", ":resize +1<CR>")
keymap("n", "<leader>sv", ":w<CR>:source %<CR>")
keymap("v", "<leader>sv", ":<c-u>w<CR>:source %<CR>")
keymap("i", "<C-b>", "<Left>", { noremap = true, desc = "Move cursor left in insert mode" })
keymap("c", "<C-b>", "<Left>", { noremap = true, desc = "Move cursor left in insert mode" })
keymap("i", "<C-f>", "<Right>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("c", "<C-f>", "<Right>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("c", "<C-g>", "<C-f>", { noremap = true, desc = "Move cursor right in insert mode" })
keymap("i", "<C-CR>", "<esc>o", { noremap = true })
-- keymap("i", "<C-k>", "<esc>o", { noremap = true })
keymap("i", "<C-j>", "<esc>o", { noremap = true })
-- keymap("i", "<C-k>", "<CR>", { noremap = true })

-- -- vim.api.nvim_input работает с передачей кода клавиш на более низком уровне
-- vim.keymap.set('i', '<C-k>', function()
--     vim.api.nvim_input(vim.api.nvim_replace_termcodes('<CR>', true, false, true))
-- end, { noremap = true, silent = true })

vim.keymap.set("i", "<C-k>", function()
    local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys(keys, "t", true)
end, { noremap = true })

keymap("n", "<leader>ni", ":Neorg index<CR>", { desc = "Move cursor right in insert mode" })
keymap("n", "<leader>R", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
keymap("n", "<leader>N", ":set number!<CR>", { desc = "Toggle number" })
keymap("n", "<leader>T", ":lua MiniFiles.open()<cr>", { desc = "Open Mini.files" })
keymap("n", "<leader>sa", "ggVG", { desc = "Select All" })
keymap("n", "<leader>cp", ":%y+<CR>", { desc = "Yank All" })
keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.cmd([[
nnoremap <leader>F :call FoldColumnd()<CR>

function! FoldColumnd()
    if &foldcolumn
        let &foldcolumn = 0
    else
        let &foldcolumn = 4
    endif
endfunction
]])

vim.cmd([[
nnoremap <leader>q :call QuickFixToggle()<cr>

let g:quickfixisopen = 0
function! QuickFixToggle()
    if g:quickfixisopen
        cclose
        let g:quickfixisopen = 0
    else
        copen
        let g:quickfixisopen = 1
    endif
endfunction
]])

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch", -- или любая другая группа подсветки
            timeout = 150, -- длительность подсветки в миллисекундах
        })
    end,
})
-- 1. Указываем, что цель - tmux
vim.g.slime_target = "tmux"

-- 2. Задаем конфигурацию по умолчанию, чтобы избежать вопросов
vim.g.slime_default_config = {
    -- Имя сокета tmux. "default" почти всегда правильно, если ты не запускал tmux с особыми флагами -L или -S.
    socket_name = "default",
    -- Целевая панель. "{last}" - панель, активная перед текущей. Идеально для переключения Neovim <-> REPL.
    target_pane = "{last}",
}

-- 3. (Рекомендуется) Включаем bracketed paste для tmux
-- Это помогает корректно вставлять многострочный код в REPL.
vim.g.slime_bracketed_paste = 1
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- Вариант А: Точно как основной фон
        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e" })

        -- Вариант Б: Чуть темнее (Mantle)
        -- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#181825" })

        -- Опционально: Настроить цвет выделения
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#313244" }) -- Surface0
        -- *** УСТАНАВЛИВАЕМ ЦВЕТ РАМКИ ***
        -- Используем цвет 'Crust' как цвет переднего плана (fg) для рамки
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#6c7086" })
    end,
})
