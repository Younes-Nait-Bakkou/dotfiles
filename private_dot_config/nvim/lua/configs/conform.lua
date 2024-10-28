local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "black" },
        htmldjango = { "djlint" },
        javascript = { "prettier" },
    },

    formatters = {
        -- Python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },

        prettier = {
            prepend_args = {
                "--print-width=90",
                "--tab-width=4",
            },
        },
    },

    format_after_save = {
        lsp_fallback = true,
    },
}

return options
