local dir_utils = require("utils.dir-utils")
local utils_path = vim.fn.stdpath("config") .. "/lua/utils/dap-ui-expressions/" -- Directory for expression files
local M = {}
local dapui = require("dapui")

-- Load expressions from project-specific file
M.load_expressions = function()
    local project_name = dir_utils.get_root_dir_name()
    local file_path = utils_path .. project_name .. ".txt"

    -- Get the current watches and remove them
    local watches = dapui.elements.watches.get()
    for i = #watches, 1, -1 do -- Loop backwards to safely remove items
        dapui.elements.watches.remove(i)
    end

    local file = io.open(file_path, "r")
    -- Load all expressions from the file
    if file then
        for line in file:lines() do
            dapui.elements.watches.add(line)
        end
        file:close()
        print("Expressions loaded from " .. file_path)
    else
        print("No saved expressions found for project: " .. project_name)
    end
end

return M
