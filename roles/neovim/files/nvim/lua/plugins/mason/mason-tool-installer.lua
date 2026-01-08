return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        require("configs.mason-tool-installer")
    end,
}
