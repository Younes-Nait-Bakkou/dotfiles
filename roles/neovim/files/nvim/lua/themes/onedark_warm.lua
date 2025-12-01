---@type Base46Table
local M = {}

local c = {
    black = "#191a1c",
    bg0 = "#2c2d30",
    bg1 = "#35373b",
    bg2 = "#3e4045",
    bg3 = "#404247",
    bg_d = "#242628",
    fg = "#b1b4b9",
    red = "#e16d77",
    green = "#99bc80",
    blue = "#68aee8",
    yellow = "#dfbe81",
    orange = "#c99a6e",
    purple = "#c27fd7",
    cyan = "#5fafb9",
    grey = "#646568",
    light_grey = "#8b8d91",
    dark_purple = "#854897",
}

M.base_30 = {
    white = c.fg,
    black = c.bg0,
    darker_black = c.black,
    black2 = c.bg1,
    one_bg = c.bg2,
    one_bg2 = c.bg3,
    one_bg3 = c.bg_d,
    grey = c.grey,
    grey_fg = c.light_grey,
    grey_fg2 = c.light_grey,
    light_grey = c.light_grey,
    red = c.red,
    baby_pink = c.red,
    pink = c.purple,
    line = c.bg3,
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
    statusline_bg = c.bg_d,
    lightbg = c.bg1,
    pmenu_bg = c.blue,
    folder_bg = c.blue,
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
    defaults = { Comment = { fg = c.grey, italic = true } },
    treesitter = { ["@variable"] = { fg = c.fg } },
}

M.type = "dark"

M = require("base46").override_theme(M, "one_dark_warm")

return M
