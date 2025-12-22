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
        yaml = {
            "yamlfix",
        },
        ["yaml.ansible"] = { "yaml_task_spacing", "yamlfix" },
        java = { "google-java-format" },
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
        prettier = {
            cmd = "prettier",
            append_args = {
                -- "--print-width=120",
                -- "--tab-width=4",
            },
        },
        yaml_task_spacing = {
            command = "python3",
            stdin = true,
            args = {
                "-c",
                [[
import sys
lines = sys.stdin.readlines()
for i, line in enumerate(lines):
    if line.startswith("- name:") and i != 0 and lines[i-1].strip() != "":
        print()
    print(line, end="")
]],
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
