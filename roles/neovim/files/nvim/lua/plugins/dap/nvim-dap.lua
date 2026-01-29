return {
    "mfussenegger/nvim-dap",
    config = function()
        require("configs.dap")
    end,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
}
