local lint = require("lint")

lint.linters_by_ft = {
    ["ansible.yaml"] = { "ansible_lint" },
    lua = { "luacheck" },
    python = {
        -- "ruff",
        "mypy",
    },
    htmldjango = { "djlint" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}
lint.linters.ansible_lint.args = {
    "--fix",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
