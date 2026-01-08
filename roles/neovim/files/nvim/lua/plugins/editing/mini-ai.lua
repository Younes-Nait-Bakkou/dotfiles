return {
    "nvim-mini/mini.ai",
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
}
