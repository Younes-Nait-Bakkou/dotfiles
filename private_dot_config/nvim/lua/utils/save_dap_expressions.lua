local utils_path = vim.fn.stdpath("config") .. "/lua/utils/dap-ui-expressions/" -- Directory for expression files
local dir_utils = require("utils.dir-utils")
local M = {}
-- Save expressions to project-specific file
M.save_expressions = function()
    dir_utils.ensure_directory_exists(utils_path)
    local project_name = dir_utils.get_root_dir_name()
    local file_path = utils_path .. project_name .. ".txt"

    local watches = require("dapui").elements.watches.get()
    local file = io.open(file_path, "w")
    if file then
        for _, watch in ipairs(watches) do
            if watch.expression then
                file:write(watch.expression .. "\n")
            end
        end
        file:close()
        print("Expressions saved to " .. file_path)
    else
        print("Failed to save expressions.")
    end
end

return M
