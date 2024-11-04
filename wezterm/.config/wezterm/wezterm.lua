local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    harfbuzz_features = { "calt=0" },
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    -- window_decorations = "RESIZE"
    default_cursor_style = "BlinkingBar",
    color_scheme = "catppuccin-mocha",
    -- color_scheme = "Gruvbox Material (Gogh)",
    -- color_scheme = 'Gruvbox dark, medium (base16)',

    -- font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
    -- font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
    font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" }),
    font_size = 21,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    colors = {
        -- Установите желаемый цвет текста под курсором
        cursor_fg = "#1e1d2c", -- Например, белый цвет
        cursor_bg = "#f1e0dc", -- Цвет фона курсора (опционально)
        -- cursor_border = "#52ad70", -- Цвет обводки курсора (опционально)
    },
    keys = {
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
        -- Добавьте другие необходимые привязки клавиш здесь
    },
}

return config
