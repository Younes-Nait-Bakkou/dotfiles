-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "gruvbox_material",
    transparency = false,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

M.ui = {
    hl_add = {
        RECORDFLAG = {
            fg = "#ff0000", -- Red color for visibility
            bold = true,
            bg = "statusline_bg",
        },
    },

    cmp = {
        icons_left = true, -- only for non-atom styles!
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        format_colors = {
            tailwind = true, -- will work for css lsp too
            icon = "󱓻",
        },
    },

    telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
        enabled = true,
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        order = { "mode", "file", "git", "macro", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor" },

        -- 3. Define the custom 'macro' module here
        -- This merges with the default modules in utils.lua
        modules = {
            macro = function()
                -- Safely require the plugin to prevent crashes if it's missing
                local ok, recorder = pcall(require, "recorder")
                if not ok then
                    return ""
                end

                local status = recorder.recordingStatus()
                local slots = recorder.displaySlots()

                -- CASE 1: Recording (Red Icon + Text)
                if status ~= "" then
                    return "%#RECORDFLAG# 󰑋 " .. status .. " "
                end

                -- CASE 2: Not Recording (Grey Icon + Slots)
                -- We use St_lspInfo to match the generic info color of your theme
                if slots ~= "" then
                    return "%#St_lspInfo# 󰃽 " .. slots .. " "
                end

                return ""
            end,
        },
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "treeOffset", "buffers", "tabs", "btns" },
        modules = nil,
    },
}

M.nvdash = {
    load_on_startup = true,
    header = {
        "                            ",
        "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
        "   ▄▀███▄     ▄██ █████▀    ",
        "   ██▄▀███▄   ███           ",
        "   ███  ▀███▄ ███           ",
        "   ███    ▀██ ███           ",
        "   ███      ▀ ███           ",
        "   ▀██ █████▄▀█▀▄██████▄    ",
        "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
        "                            ",
        "     Powered By  eovim    ",
        "                            ",
    },

    buttons = {
        { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
        { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
        { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
        { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
        { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

        {
            txt = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime) .. " ms"
                return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
            end,
            hl = "NvDashFooter",
            no_gap = true,
        },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
}

return M
