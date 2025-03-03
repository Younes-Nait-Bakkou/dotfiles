local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "black" },
        htmldjango = { "djlint" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        blade = { "prettier" },
        sh = { "shfmt" },
    },

    formatters = {
        -- Python
        black = {
            prepend_args = {},
        },

        djlint = {
            cmd = "djlint",
            append_args = {
                -- "--line-break-after-multiline-tag",
                "--max-attribute-length=70",
                "--max-line-length=120",
            },
        },

        -- prettier = {
        --     prepend_args = {
        --         "--print-width=120",
        --         "--tab-width=2",
        --         "--use-tabs",
        --         "--bracket-same-line",
        --         "--single-attribute-per-line",
        --     },
        -- },
    },

    format_after_save = {
        lsp_fallback = true,
    },
}

return options
