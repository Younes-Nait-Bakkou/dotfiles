return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    event = { "VeryLazy" },
    config = function()
        require("configs.no-neck-pain")
    end,
}
