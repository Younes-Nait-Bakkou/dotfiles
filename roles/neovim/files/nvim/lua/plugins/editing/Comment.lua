return {
    "numToStr/Comment.nvim",
    event = { "FileType" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("configs.Comment")
    end,
}
