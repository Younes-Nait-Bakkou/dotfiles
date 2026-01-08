return {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    opts = {
        multi_windows = true,
        keys = "etovxqpdygfblzhckisuran",
        uppercase_levels = true,
    },
    keys = {
        {
            "<leader>fj",
            function()
                require("hop").hint_words()
            end,
            mode = { "n", "x", "o" },
        },
    },
}
