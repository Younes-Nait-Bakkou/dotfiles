local M = {}

-- Ensure the directory exists
M.ensure_directory_exists = function(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end
end

-- Get the current project name based on the root directory
M.get_root_dir_name = function()
    local root_dir = vim.fn.getcwd()
    local root_dir_name = vim.fn.fnamemodify(root_dir, ":t") -- Gets the current directory name
    return root_dir_name
end

return M
