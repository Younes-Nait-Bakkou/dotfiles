local cmp = require("cmp")
local lspkind = require("lspkind")
-- create a javascript function

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    mapping = {
        -- Customize Tab key to navigate and confirm completions
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm selection
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmp_tabnine", priority = 1000 },
    },

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = { TabNine = "⚡" }, -- Sets TabNine's icon to a lightning bolt
            menu = {
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                TabNine = "[AI]", -- This sets "AI" label to TabNine source
            },
        }),
    },

    window = {
        completion = cmp.config.window.bordered({
            width = 50, -- Set width to fit TabNine's longer suggestions
        }),
        documentation = cmp.config.window.bordered(),
    },

    -- experimental = {
    --     ghost_text = true,
    -- },
})

cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})

cmp.setup.filetype({ "html", "htmldjango" }, {
    sources = cmp.config.sources({
        { name = "cmp_bootstrap" },
        -- other sources
    }),
})
