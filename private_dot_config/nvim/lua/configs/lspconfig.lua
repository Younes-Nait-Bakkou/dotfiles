local utils = require("utils")

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "pyright",
    -- "ts_ls",
    "html",
    "cssls",
    "ruff",
    "eslint",
    "tailwindcss",
    "phpactor",
    -- "jinja_lsp", -- Needs "carbon"
    -- "typescript-tools",
    "jdtls",
}
-- list of servers configured with default config.
local default_servers = {
    -- "ts_ls",
    -- "lua_ls",
    -- "pyright",
    "html",
    "cssls",
    "ruff",
    "tailwindcss",
    -- "jinja_lsp",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                -- enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = (function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
        return capabilities
    end)(),

    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "none",
                    reportUnusedImport = "none",
                },
                typeCheckingMode = "off",
            },
            pythonPath = utils.venv_python_path(),
        },
    },
})

-- lspconfig.ts_ls.setup({
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--
--     settings = {
--         typescript = {
--             preferences = {
--                 disableSuggestions = true,
--             },
--         },
--     },
-- })

-- lspconfig.typescript_tools.setup({
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--
--     settings = {
--         -- spawn additional tsserver instance to calculate diagnostics on it
--         separate_diagnostic_server = true,
--         -- "change"|"insert_leave" determine when the client asks the server about diagnostic
--         publish_diagnostic_on = "insert_leave",
--         -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
--         -- "remove_unused_imports"|"organize_imports") -- or string "all"
--         -- to include all supported code actions
--         -- specify commands exposed as code_actions
--         expose_as_code_action = {},
--         -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
--         -- not exists then standard path resolution strategy is applied
--         tsserver_path = nil,
--         -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
--         -- (see 💅 `styled-components` support section)
--         tsserver_plugins = {},
--         -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
--         -- memory limit in megabytes or "auto"(basically no limit)
--         tsserver_max_memory = "auto",
--         -- described below
--         tsserver_format_options = {},
--         tsserver_file_preferences = {},
--         -- locale of all tsserver messages, supported locales you can find here:
--         -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
--         tsserver_locale = "en",
--         -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
--         complete_function_calls = false,
--         include_completions_with_insert_text = true,
--         -- CodeLens
--         -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
--         -- possible values: ("off"|"all"|"implementations_only"|"references_only")
--         code_lens = "off",
--         -- by default code lenses are displayed on all referencable values and for some of you it can
--         -- be too much this option reduce count of them by removing member references from lenses
--         disable_member_code_lens = true,
--         -- JSXCloseTag
--         -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
--         -- that maybe have a conflict if enable this feature. )
--         jsx_close_tag = {
--             enable = false,
--             filetypes = { "javascriptreact", "typescriptreact" },
--         },
--     },
-- })

lspconfig.eslint.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    flags = {
        allow_incremental_sync = false,
        debounce_text_changes = 1000,
    },

    settings = {
        packageManager = "npm",
        validate = "on",
        format = true,
        run = "onSave",
        nodePath = "",
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine",
            },
            showDocumentation = {
                enable = true,
            },
        },
        codeActionOnSave = {
            enable = true,
            mode = "all",
        },
        workingDirectory = {
            mode = "auto",
        },
    },
})

local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
phpactor_capabilities["textDocument"]["codeAction"] = {}

lspconfig.phpactor.setup({
    root_dir = function(_)
        return vim.loop.cwd()
    end,
    capabilities = phpactor_capabilities,
    on_attach = on_attach,
    init_options = {
        ["language_server.diagnostics_on_update"] = false,
        ["language_server.diagnostics_on_open"] = false,
        ["language_server.diagnostics_on_save"] = false,
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    },
})
