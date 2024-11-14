require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
        ["html"] = {
            enable_close = false,
        },
        ["htmldjango"] = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true, -- Auto close on trailing </
        },
    },
    aliases = {
        ["htmldjango"] = "html",
    },
})

local TagConfigs = require("nvim-ts-autotag.config.init")
TagConfigs:add_alias("htmldjango", "html")
