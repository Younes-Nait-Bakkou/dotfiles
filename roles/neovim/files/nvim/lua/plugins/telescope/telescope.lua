return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                -- Only try to load/build if make is available
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-media-files.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-frecency.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "isak102/telescope-git-file-history.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "tpope/vim-fugitive",
            },
        },
    },
    config = function()
        require("configs.telescope")
    end,
}
