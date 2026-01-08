return {
    "onsails/lspkind.nvim",
    event = { "InsertEnter" },
    config = function()
        require("configs.lspkind")
    end,
}
