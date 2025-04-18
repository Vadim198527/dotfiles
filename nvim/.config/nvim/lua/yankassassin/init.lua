local M = {}

local auto_normal = false
local auto_visual = false
local pre_yank_pos = {}

-- [+] Добавим хелпер для проверки nvim-tree
local function is_nvim_tree_buffer()
    -- Проверяем filetype - самый надежный способ
    if vim.bo.filetype == "NvimTree" then
        return true
    end
    -- Дополнительно проверим имя буфера (на всякий случай)
    local success, bufname = pcall(vim.api.nvim_buf_get_name, 0)
    if success and type(bufname) == 'string' and bufname:match("NvimTree_") then
        return true
    end
    return false
end

-- To save register for mappings
local my_register = ""
local function save_register()
    my_register = vim.v.register == "" and '"' or vim.v.register
end

-- Function to save the cursor position before yanking (Оригинал)
local function pre_yank_motion()
    -- Обернем в pcall для безопасности, т.к. CursorMoved вызывается часто
    local success, pos = pcall(vim.api.nvim_win_get_cursor, 0)
    if success and pos then
        pre_yank_pos = pos
    -- else: Не очищаем здесь, т.к. позиция может скоро понадобиться (логика оригинала)
    end
end

-- Function to restore the cursor position after yanking (Оригинал + Проверка)
local function post_yank_motion()
    -- [+] Добавим проверку nvim-tree здесь для безопасности
    if is_nvim_tree_buffer() then
        return
    end

    -- Проверяем, что позиция сохранена и валидна
    if pre_yank_pos and type(pre_yank_pos) == 'table' and #pre_yank_pos > 0 then
       -- Обернем установку курсора в pcall для безопасности
       pcall(vim.api.nvim_win_set_cursor, 0, pre_yank_pos)
       -- [+] Очистим позицию после использования. Если это сломает логику,
       -- можно убрать эту строку, но это менее безопасно.
       pre_yank_pos = {}
    end
end

local function setup_autocmds()
    local group = vim.api.nvim_create_augroup("YankAssassinMinimalFix", { clear = true }) -- Новая группа для чистоты

    -- Original CursorMoved logic
    vim.api.nvim_create_autocmd({ "VimEnter", "CursorMoved" }, {
        group = group,
        callback = function()
            -- Вызываем pre_yank_motion как в оригинале
            pre_yank_motion() -- pcall уже внутри pre_yank_motion
        end,
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
        group = group,
        callback = function()
            -- *** [+] ГЛАВНОЕ ИЗМЕНЕНИЕ: Проверка nvim-tree в самом начале ***
            if is_nvim_tree_buffer() then
                return -- Ничего не делаем, если yank произошел в nvim-tree
            end

            -- Оригинальная логика колбэка
            local operators = { "y" } -- Add more operators here if needed
            if vim.tbl_contains(operators, vim.v.event.operator) then
                local myMode = vim.api.nvim_get_mode().mode
                -- Оригинальная проверка режима
                if (auto_normal and myMode == "no") or (auto_visual and myMode == "n") then
                    post_yank_motion()
                end
            end
        end,
    })
end

-- Copy of vim's default yank operator (Оригинал + pcall)
local function yank_operator(type)
    local expr
    if type == "char" then
        expr = "`[v`]"
    elseif type == "line" then
        expr = "'[V']"
    elseif type == "block" then
        expr = "`[<C-v>`]"
    end
    -- Обернем в pcall для безопасности
    pcall(vim.cmd, "keepjumps normal! " .. expr .. '"' .. my_register .. "y")
end

-- Move the cursor to the start - default behavior (Оригинал + pcall)
function M.default_yank_operator(type)
    yank_operator(type)
    pcall(vim.cmd, "normal! `[")
end

-- Do not move the cursor to the start (Оригинал + Проверка)
function M.special_yank_operator(type)
    -- Важно: Маппинг <Plug>(YANoMove) вызывает pre_yank_motion прямо перед этим
    yank_operator(type)
    -- [+] Добавим проверку nvim-tree перед восстановлением
    if not is_nvim_tree_buffer() then
       post_yank_motion()
    else
       -- На всякий случай очистим, если мы как-то попали сюда в nvim-tree
       pre_yank_pos = {}
    end
end

function M.setup(opts)
    opts = opts or {}
    auto_normal = opts.auto_normal or false
    auto_visual = opts.auto_visual or false

    -- Устанавливаем автокоманды (Оригинал + Минимальный фикс)
    setup_autocmds()

    -- Default behavior mapping (Оригинал)
    vim.keymap.set("n", "<Plug>(YADefault)", function()
        save_register()
        vim.go.operatorfunc = "v:lua.require'YankAssassin'.default_yank_operator"
        return "g@"
    end, { expr = true, noremap = true, silent = true })

    vim.keymap.set({ "x", "v" }, "<Plug>(YADefault)", function()
        save_register()
        vim.cmd("normal! " .. '"' .. my_register .. "y")
        vim.cmd("normal! `[")
    end, { noremap = true, silent = true })

    -- NoMove behavior mapping (Normal mode - Оригинал + Проверка)
    vim.keymap.set("n", "<Plug>(YANoMove)", function()
        save_register()
        -- [+] Вызываем pre_yank_motion только если НЕ в nvim-tree
        if not is_nvim_tree_buffer() then
           pre_yank_motion()
        else
           pre_yank_pos = {} -- Очищаем, если в nvim-tree
        end
        vim.go.operatorfunc = "v:lua.require'YankAssassin'.special_yank_operator"
        return "g@"
    end, { expr = true, noremap = true, silent = true })

    -- NoMove behavior mapping (Visual mode - Оригинал + Проверка)
     vim.keymap.set({ "x", "v" }, "<Plug>(YANoMove)", function()
         -- [+] Проверяем nvim-tree в начале
         if is_nvim_tree_buffer() then
             -- Стандартное поведение yank в nvim-tree
             save_register()
             vim.cmd("normal! " .. '"' .. my_register .. "y")
             vim.cmd("normal! `[")
         else
             -- Оригинальное поведение плагина
             save_register()
             pre_yank_motion() -- Сохраняем позицию перед yank
             vim.cmd("normal! " .. '"' .. my_register .. "y")
             post_yank_motion() -- Восстанавливаем позицию
         end
     end, { noremap = true, silent = true })
end

return M
