---@type Base46Table
local M = {}

local c = {
    black = "#0c0e15",
    bg0 = "#1a212e",
    bg1 = "#21283b",
    bg2 = "#283347",
    bg3 = "#2a324a",
    bg_d = "#141b24",
    fg = "#93a4c3",
    red = "#f65866",
    green = "#8bcd5b",
    blue = "#41a7fc",
    yellow = "#efbd5d",
    orange = "#dd9046",
    purple = "#c75ae8",
    cyan = "#34bfd0",
    grey = "#455574",
    light_grey = "#6c7d9c",
    dark_purple = "#862aa1",
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

M = require("base46").override_theme(M, "one_dark_deep")

return M
