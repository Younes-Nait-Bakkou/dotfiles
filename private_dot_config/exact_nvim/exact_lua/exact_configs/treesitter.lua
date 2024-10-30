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

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- Jump to the outer tag
                ["<leader>ot"] = { query = "@tag.outer", desc = "Select outer tag" },
                -- Jump to the inner content within tags
                ["<leader>it"] = { query = "@tag.inner", desc = "Select inner tag content" },
            },
        },

        move = {
            enable = true,
            set_jumps = true,

            -- Movement to the start of the next outer tag
            goto_next_start = {
                ["]t"] = {
                    query = "@tag.outer", -- Moves to the start of the next tag
                    query_group = "html", -- Group specifying we're working with HTML tags
                    desc = "Next tag start", -- Description for the movement
                },
            },

            -- Movement to the end of the next outer tag
            goto_next_end = {
                ["]T"] = {
                    query = "@tag.outer", -- Moves to the end of the next tag
                    query_group = "html",
                    desc = "Next tag end",
                },
            },

            -- Movement to the start of the previous outer tag
            goto_previous_start = {
                ["[t"] = {
                    query = "@tag.outer", -- Moves to the start of the previous tag
                    query_group = "html",
                    desc = "Previous tag start",
                },
            },

            -- Movement to the end of the previous outer tag
            goto_previous_end = {
                ["[T"] = {
                    query = "@tag.outer", -- Moves to the end of the previous tag
                    query_group = "html",
                    desc = "Previous tag end",
                },
            },
        },
    },

    autotag = true,

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
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[ set nofoldenable]])
-- vim.opt.foldlevel = 99
