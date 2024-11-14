vim.api.nvim_create_autocmd({ "FileType", "BufReadPost", "BufEnter" }, {
    pattern = "*.htmldjango",
    callback = function()
        vim.bo.commentstring = "{#-- %s --#}"
    end,
})
