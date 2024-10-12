local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    harfbuzz_features = { "calt=0" },
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    -- window_decorations = "RESIZE"
    default_cursor_style = "BlinkingBar",
    -- color_scheme = "catppuccin-mocha",
    color_scheme = "Gruvbox Material (Gogh)",
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
}

return config
