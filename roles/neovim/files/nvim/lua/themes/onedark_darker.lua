---@type Base46Table
local M = {}

local c = {
    black = "#0e1013",
    bg0 = "#1f2329",
    bg1 = "#282c34",
    bg2 = "#30363f",
    bg3 = "#323641",
    bg_d = "#181b20",
    fg = "#a0a8b7",
    red = "#e55561",
    green = "#8ebd6b",
    blue = "#4fa6ed",
    yellow = "#e2b86b",
    orange = "#cc9057",
    purple = "#bf68d9",
    cyan = "#48b0bd",
    grey = "#535965",
    light_grey = "#7a818e",
    dark_purple = "#7e3992",
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
M = require("base46").override_theme(M, "one_dark_darker")
return M
