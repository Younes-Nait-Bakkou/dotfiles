-- require("configs.filetype-configs.htmldjango")

return {
    -- Neovim session management, good for not having to re-open the same files after exit
    {
        "gennaro-tedesco/nvim-possession",
        event = { "VimEnter" },
        dependencies = {
            "ibhagwan/fzf-lua",
        },
        config = function()
            require("configs.possession")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require("configs.conform"),
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("configs.treesitter")
            require("configs.ts-autotag")
        end,
    },

    {
        "nvim-treesitter/playground",
        dependencies = {
            "nvim-treesitter",
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("configs.tree")
        end,
    },

    {
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
            {
                "tpope/vim-dotenv",
                config = function()
                    require("dotenv")
                        .setup({
                            enable_on_load = true,
                            verbose = true,
                        })
                        .load()
                end,
            },
        },
    },

    {
        "nvim-neotest/nvim-nio",
    },

    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            require("configs.dap-python")
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("configs.dap-ui")
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("configs.dap-virtual-text")
        end,
    },

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            require("configs.dap")
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.mason-dap")
        end,
    },

    -- LSP-used navigation made easy.
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("configs.lspsaga")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons", -- optional
        },
    },

    -- Mini icons
    {
        "echasnovski/mini.hipatterns",
        event = "BufReadPre",
        config = function()
            require("configs.mini-hipatterns")
        end,
    },

    -- {
    --     "rcarriga/nvim-notify",
    --     config = function()
    --         require("configs.notify")
    --     end,
    -- },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.noice")
        end,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
    },

    -- Integrated database access plugins
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            require("utils.load_env")
            require("configs.dadbod-ui")
        end,
    },

    {
        "onsails/lspkind.nvim",
        event = { "InsertEnter" },
        config = function()
            require("configs.lspkind")
        end,
    },

    -- Code completion handler
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("configs.cmp")
        end,
    },

    -- Bootstrap code completion.
    {
        "rambhosale/cmp-bootstrap.nvim",
        event = "InsertEnter",
    },

    -- Navigating between marked lines.
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Select multiple occurances of the same selection.
    {
        "mg979/vim-visual-multi",
        event = { "BufEnter" },
        branch = "master",
    },

    -- Comment formats for different file types, example: Django => {# #}
    {
        "numToStr/Comment.nvim",
        event = { "FileType" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("configs.Comment")
        end,
    },

    -- Tabnine AI code completion
    -- {
    --     "codota/tabnine-nvim",
    --     event = { "InsertEnter" },
    --     build = "./dl_binaries.sh",
    --     config = function()
    --         require("configs.tabnine")
    --     end,
    -- },

    {
        "tzachar/cmp-tabnine",
        event = { "BufEnter" },
        build = "./install.sh",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
}
