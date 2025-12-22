vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function(args)
        require("configs.jdtls-setup").setup_jdtls()
    end,
})
