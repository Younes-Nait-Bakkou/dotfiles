return {
    "elmcgill/springboot-nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-jdtls",
    },
    config = function()
        require("configs.springboot-nvim")
    end,
}
