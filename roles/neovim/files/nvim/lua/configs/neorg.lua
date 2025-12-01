local neorg = require("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
            config = {
                icons = {
                    todo = {
                        on_hold = "◾",
                        rescheduled = "◾",
                        waiting = "◾",
                        done = "✓",
                        cancelled = "✘",
                        important = "‼",
                        wip = "→",
                    },
                },
            },
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes",
                    journal = "~/journal",
                    garden = "~/garden",
                },
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
            },
        },
        ["core.highlights"] = {
            config = {
                use_treesitter = true,
                links = {
                    ["@punctuation.special"] = "SpecialChar",
                    ["@text.literal"] = "String",
                    ["@text.reference"] = "String",
                    ["@text.title"] = "Title",
                    ["@text.todo"] = "Todo",
                    ["@tag"] = "Label",
                    ["@tag.attribute"] = "Number",
                    ["@tag.delimiter"] = "Delimiter",
                    ["@tag.special"] = "Special",
                },
            },
        },
        -- ["core.norg.journal"] = {
        --     config = {
        --         workspace = "journal",
        --     },
        -- },
        -- ["core.norg.denodo"] = {
        --     config = {
        --         workspace = "garden",
        --     },
        -- },
    },
})
