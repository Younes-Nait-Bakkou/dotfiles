return {
    "Vigemus/iron.nvim",
    cmd = { "IronRepl", "IronReplAttach" },
    config = function()
        require("configs.iron")
    end,
}
