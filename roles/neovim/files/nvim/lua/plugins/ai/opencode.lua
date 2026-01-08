return {
    "NickvanDyke/opencode.nvim",
    event = "VeryLazy",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `toggle()`.
        { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
        { "folke/which-key.nvim" },
    },
    config = function()
        require("configs.opencode").setup()
    end,
}
