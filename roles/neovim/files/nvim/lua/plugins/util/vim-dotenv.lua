return {
    "tpope/vim-dotenv",
    config = function()
        require("dotenv")
            .setup({
                enable_on_load = true,
                verbose = true,
            })
            .load()
    end,
}
