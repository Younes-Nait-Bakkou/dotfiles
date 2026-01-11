---@type Base46Table
local M = {}

-- Gruvbox Material (Hard) Palette
local c = {
    black = "#171a1b", -- Darker black (for terminals/sidebars)
    bg0 = "#1d2021", -- Main Background (Hard contrast)
    bg1 = "#282828", -- Lighter background (Panels/Statusline)
    bg2 = "#32302f", -- Selection/Split lines
    bg3 = "#3c3836", -- Lighter accents
    bg_d = "#1d2021", -- Default background
    fg = "#d4be98", -- Foreground (Cream)
    red = "#ea6962",
    green = "#a9b665",
    blue = "#7daea3",
    yellow = "#d8a657",
    orange = "#e78a4e",
    purple = "#d3869b",
    cyan = "#89b482",
    grey = "#504945",
    light_grey = "#7c6f64",
    dark_purple = "#d3869b",
}

M.base_30 = {
    white = c.fg,
    black = c.bg0,
    darker_black = c.black,
    black2 = c.bg1,
    one_bg = c.bg1, -- Statusline bg
    one_bg2 = c.bg2, -- Line bg
    one_bg3 = c.bg3,
    grey = c.grey,
    grey_fg = c.light_grey,
    grey_fg2 = c.light_grey,
    light_grey = c.light_grey,
    red = c.red,
    baby_pink = c.red,
    pink = c.purple,
    line = c.bg2,
    green = c.green,
    vibrant_green = c.green,
    nord_blue = c.blue,
    blue = c.blue,
    seablue = c.blue,
    yellow = c.yellow,
    sun = c.orange,
    purple = c.purple,
    dark_purple = c.dark_purple,
    teal = c.cyan,
    orange = c.orange,
    cyan = c.cyan,
    statusline_bg = c.bg1,
    lightbg = c.bg2,
    pmenu_bg = c.bg1, -- Popups match panels
    folder_bg = c.blue, -- Blue folders look best in Gruvbox
}

M.base_16 = {
    base00 = c.bg0,
    base01 = c.bg1,
    base02 = c.bg2,
    base03 = c.grey,
    base04 = c.light_grey,
    base05 = c.fg,
    base06 = c.light_grey,
    base07 = c.fg,
    base08 = c.red,
    base09 = c.orange,
    base0A = c.yellow,
    base0B = c.green,
    base0C = c.cyan,
    base0D = c.blue,
    base0E = c.purple,
    base0F = c.red,
}

M.polish_hl = {
    defaults = {
        Comment = { fg = c.grey, italic = true },
        -- Fix transparent background issues if you enable transparency
        Normal = { bg = c.bg0 },
    },
    treesitter = {
        ["@variable"] = { fg = c.fg },
    },
}

M.type = "dark"

return M
