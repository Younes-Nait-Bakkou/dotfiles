return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "kristijanhusak/vim-dadbod-completion",
        "rcarriga/cmp-dap",
        "ray-x/cmp-treesitter",
    },
    config = function()
        require("configs.cmp")
    end,
}
