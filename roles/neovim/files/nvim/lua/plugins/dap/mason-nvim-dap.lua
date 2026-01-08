return {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    config = function()
        require("configs.mason-dap")
    end,
}
