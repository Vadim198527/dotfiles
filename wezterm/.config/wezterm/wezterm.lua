local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    -- Получаем заголовок активного окна
    local title = tab.active_pane.title
    -- Здесь вы можете изменить title по своему усмотрению
    -- Например, добавить номер вкладки:
    return string.format(" %d: %s ", tab.tab_index + 1, title)
end)

config = {
    automatically_reload_config = true,
    harfbuzz_features = { "calt=0" },

    -- enable_tab_bar = false,
    tab_bar_at_bottom = false,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    -- window_decorations = "RESIZE"
    default_cursor_style = "BlinkingBar",
    -- color_scheme = "catppuccin-mocha",
    -- color_scheme = "Catppuccin Macchiato",
    -- Установите уровень прозрачности (от 0.0 до 1.0)
    -- window_background_opacity = 0.8,

    -- Установите степень размытия фона (0 отключает размытие)
    -- macos_window_background_blur = 50,
    -- color_scheme = "Gruvbox Material (Gogh)",
    color_scheme = "Gruvbox dark, medium (base16)",

    -- font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
    font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
    -- font = wezterm.font("JetBrainsMonoNL Nerd Font Mono"),
    -- font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" }),
    -- font = wezterm.font_with_fallback({
    --     {
    --         family = "JetBrains Mono",
    --         weight = "Medium",
    --         harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    --     },
    --     { family = "Terminus", weight = "Bold" },
    --     "Noto Color Emoji",
    -- }),
    font_size = 17,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = "0",
    },
    colors = {
        -- Установите желаемый цвет текста под курсором
        cursor_fg = "#1e1d2c", -- Например, белый цвет
        cursor_bg = "#f1e0dc", -- Цвет фона курсора (опционально)

        tab_bar = {
            -- Цвет фона панели вкладок
            background = "#1e1e1e",

            -- Активная вкладка
            active_tab = {
                bg_color = "#3b4439",
                fg_color = "#ebdbb2",
                intensity = "Bold",
                -- underline = "Single",
                italic = false,
                strikethrough = false,
            },

            -- Неактивные вкладки
            inactive_tab = {
                bg_color = "#2d2d2d",
                fg_color = "#ebdbb2",
                fg_color = "#d4d4d4",
            },

            -- Неактивные вкладки при наведении курсора
            inactive_tab_hover = {
                bg_color = "#3e3e3e",
                fg_color = "#ffffff",
                italic = true,
            },

            -- Кнопка новой вкладки
            new_tab = {
                bg_color = "#1e1e1e",
                fg_color = "#d4d4d4",
            },

            -- Кнопка новой вкладки при наведении
            new_tab_hover = {
                bg_color = "#007acc",
                fg_color = "#ffffff",
                italic = true,
            },
        },
    },
    leader = {
        key = "j",
        mods = "CMD",
        timeout_milliseconds = 5000,
    },
    keys = {
        {
            key = "Enter",
            mods = "ALT",
            action = wezterm.action.DisableDefaultAssignment,
        },
        -- {
        --     key = "'",
        --     mods = "CTRL",
        --     action = wezterm.action.SendString("\x1b[39;5u"),
        -- },
        {
            key = "c",
            mods = "LEADER",
            action = wezterm.action.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = "x",
            mods = "LEADER",
            action = wezterm.action.CloseCurrentPane({ confirm = true }),
        },
        { key = "1", mods = "CMD", action = wezterm.action.SendKey({ key = "1", mods = "ALT" }) },
        { key = "2", mods = "CMD", action = wezterm.action.SendKey({ key = "2", mods = "ALT" }) },
        { key = "3", mods = "CMD", action = wezterm.action.SendKey({ key = "3", mods = "ALT" }) },
        { key = "4", mods = "CMD", action = wezterm.action.SendKey({ key = "4", mods = "ALT" }) },
        { key = "5", mods = "CMD", action = wezterm.action.SendKey({ key = "5", mods = "ALT" }) },
        { key = "6", mods = "CMD", action = wezterm.action.SendKey({ key = "6", mods = "ALT" }) },
        { key = "7", mods = "CMD", action = wezterm.action.SendKey({ key = "7", mods = "ALT" }) },
        { key = "8", mods = "CMD", action = wezterm.action.SendKey({ key = "8", mods = "ALT" }) },
        { key = "8", mods = "CMD", action = wezterm.action.SendKey({ key = "8", mods = "ALT" }) },

        {
            key = "/",
            mods = "LEADER",
            action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        -- {
        -- 	key = "h",
        -- 	mods = "ALT",
        -- 	action = wezterm.action.ActivatePaneDirection("Left"),
        -- },
        {
            mods = "ALT",
            key = "h",
            action = wezterm.action.ActivateTabRelative(-1),
        },
        {
            mods = "ALT",
            key = "l",
            action = wezterm.action.ActivateTabRelative(1),
        },
        -- Переопределяем Cmd+C
        {
            key = "c",
            mods = "CMD",
            action = wezterm.action_callback(function(window, pane)
                -- Проверяем, есть ли выделение мышью
                local has_selection = window:get_selection_text_for_pane(pane) ~= ""
                if has_selection then
                    -- Если есть выделение, копируем его в буфер обмена
                    window:copy_to_clipboard()
                    -- Снимаем выделение, если хотите
                    window:clear_selection()
                else
                    -- Если нет выделения, отправляем сочетание клавиш в Neovim
                    window:perform_action(
                        wezterm.action.SendString("\x1b[99;9u"), -- Отправляем ESC [99;9u
                        pane
                    )
                end
            end),
        },
        -- Оставляем Cmd+V для вставки
        {
            key = "v",
            mods = "CMD",
            action = wezterm.action.PasteFrom("Clipboard"),
        },
        {
            key = "j",
            mods = "CMD",
            action = wezterm.action.SendKey({ key = "j", mods = "ALT" }),
        },
    },
}

-- for i = 1, 9 do
-- table.insert(config.keys, {
-- key = tostring(i),
-- mods = "LEADER",
-- action = wezterm.action.ActivateTab(i),
-- })
-- end

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CMD",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return config
