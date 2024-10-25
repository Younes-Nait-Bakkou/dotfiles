-- load defaults i.e lua_lsp
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
    "ruff",
    "eslint",
    -- "tailwindcss",
    -- "jinja_lsp", -- Needs "carbon"
}
-- list of servers configured with default config.
local default_servers = {
    -- "ts_ls",
    -- "lua_ls",
    -- "pyright",
    "html",
    "cssls",
    "ruff",
    -- "tailwindcss",
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
                    reportUnusedVariable = "warning", -- or anything
                },
                typeCheckingMode = "basic",
            },
        },
    },
})

lspconfig.ts_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        typescript = {
            preferences = {
                disableSuggestions = true,
            },
        },
    },
})

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
