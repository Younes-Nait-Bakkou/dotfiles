local options = {
    ensure_installed = {
        "bash",
        "fish",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "python",
        "html",
        "htmldjango",
        "tsx",
        "typescript",
        "javascript",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },
    fold = {
        enable = true,
    },
    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)

-- Enable Treesitter folding
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevel = 99
