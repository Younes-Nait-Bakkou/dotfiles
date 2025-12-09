-- require("configs.filetype-configs.htmldjango")
require("myplugins.floating-terminal")

return {
    -- Neovim session management, good for not having to re-open the same files after exit
    -- {
    --     "gennaro-tedesco/nvim-possession",
    --     event = { "VimEnter" },
    --     dependencies = {
    --         "ibhagwan/fzf-lua",
    --     },
    --     config = function()
    --         require("configs.possession")
    --     end,
    -- },

    -- ansible filetype detection
    { "pearofducks/ansible-vim", event = "VeryLazy" },

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

    -- playground for treesitter
    -- {
    --     "nvim-treesitter/playground",
    --     lazy = true,
    --     dependencies = {
    --         "nvim-treesitter",
    --     },
    -- },

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

    -- Mini hipatterns (highlight patterns)
    {
        { "echasnovski/mini.hipatterns", version = "*" },
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
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
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
        dependencies = {
            "kristijanhusak/vim-dadbod-completion",
            "rcarriga/cmp-dap",
            "ray-x/cmp-treesitter",
        },
        config = function()
            require("configs.cmp")
        end,
    },

    -- Bootstrap code completion.
    -- {
    --     "rambhosale/cmp-bootstrap.nvim",
    --     event = "InsertEnter",
    -- },

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

    -- Better replacement for ts_ls LSP
    {
        "pmizio/typescript-tools.nvim",
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("configs.typescript-tools")
        end,
    },

    -- To stay centered even at the last line of the file
    -- {
    --     "arnamak/stay-centered.nvim",
    --     opts = function()
    --         require("stay-centered").setup({
    --             -- Add any configurations here, like skip_filetypes if needed
    --             -- skip_filetypes = {"lua", "typescript"},
    --         })
    --     end,
    -- },

    -- Git Integration
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        lazy = true,
    },

    -- Subtle, yet eye-easing animations
    -- {
    --     "echasnovski/mini.animate",
    --     version = false,
    --     event = { "BufEnter" },
    -- },

    -- Ways to display and navigate diagnostics
    {
        "folke/trouble.nvim",
        lazy = true,
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- lua with lazy.nvim
    {
        "max397574/better-escape.nvim",
        config = function()
            require("configs.better-escape")
        end,
    },

    -- Dead simple plugin to center the currently focused buffer to the middle of the screen.
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        event = { "VeryLazy" },
        config = function()
            require("configs.no-neck-pain")
        end,
    },

    -- Harpoon, for making frequent-accessed buffers in one window
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = { "BufEnter" },
        config = function()
            require("configs.harpoon")
        end,
    },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
            { "g", mode = { "x", "o" } },
        },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        config = function()
            require("configs.mini-ai")
        end,
    },

    -- Creating a scratch buffer plugin
    -- {
    --     dir = "~/codes/Neovim/plugins/scratch-buffer",
    --     name = "scratch-buffer",
    --     event = { "VimEnter" },
    --     config = function()
    --         require("scratch-buffer").setup()
    --     end,
    -- },

    -- Adds more useful mappings for [ and ]
    {
        "tpope/vim-unimpaired",
        event = { "BufEnter" },
    },

    -- Adds integration for other plugins to work with the repeat '.'
    {
        "tpope/vim-repeat",
        event = { "BufEnter" },
    },

    -- Useful for manipulating surroundings like braces, quotes, brackets, XML tags, ...
    {
        "tpope/vim-surround",
        event = { "BufEnter" },
    },

    -- Auto-Install LSPs, linters, formatters, debuggers.
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = { "VeryLazy" },
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("configs.mason-tool-installer")
        end,
    },

    -- Extensions for the built-in LSP of Java
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },

    -- Quickly preview markdown
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     lazy = true,
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     build = "cd app && npm install",
    --     init = function()
    --         vim.g.mkdp_filetypes = { "markdown" }
    --     end,
    --     ft = { "markdown" },
    -- },

    -- Material theme
    -- {
    --     "marko-cerovac/material.nvim",
    --     config = function()
    --         require("configs.material")
    --     end,
    -- },
    --

    -- AI code completion assistant
    {
        "supermaven-inc/supermaven-nvim",
        event = { "VeryLazy" },
        config = function()
            require("configs.supermaven")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    -- Only try to load/build if make is available
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-media-files.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-frecency.nvim" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
            { "nvim-telescope/telescope-symbols.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "tpope/vim-fugitive",
                },
            },
        },
        config = function()
            require("configs.telescope")
        end,
    },

    -- REPL for Neovim
    {
        "Vigemus/iron.nvim",
        cmd = { "IronRepl", "IronReplAttach" },
        config = function()
            require("configs.iron")
        end,
    },

    -- SpringBoot helper for Neovim
    {
        "elmcgill/springboot-nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-jdtls",
        },
        config = function()
            require("configs.springboot-nvim")
        end,
    },

    -- Neorg, a modern notebook interface for Neovim
    {
        "nvim-neorg/neorg",
        version = "*", -- Pin Neorg to the latest stable release
        cmd = "Neorg",
        config = function()
            require("configs.neorg")
        end,
    },

    -- Better refactoring experience (crashes neovim)
    -- {
    --     "ThePrimeagen/refactoring.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     lazy = false,
    --     config = function()
    --         require("configs.refactoring")
    --     end,
    -- },
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require("mini.icons").setup() -- optional: customize here
        end,
    },
    -- {
    --     "akinsho/git-conflict.nvim",
    --     version = "*",
    --     event = { "VeryLazy" },
    --     config = true,
    -- },

    {
        "Kurama622/llm.nvim",
        cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
        config = function()
            require("configs.llm-nvim").setup()
        end,
        keys = {
            { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
        },
    },

    -- Internal markdown server previewer
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- Markdown rendering in Buffers
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
}
