local M = {}

function M.setup(bufnr)
    local get_curr_buf_info = require("commands.java.get_curr_buf_info")
    get_curr_buf_info.setup(bufnr)

    local buf_package_name = get_curr_buf_info.package_name
    local buf_class_name = get_curr_buf_info.class_name

    -- vim.print("buf_package_name", buf_package_name)
    -- vim.print("buf_class_name", buf_class_name)

    local on_exit = function(obj)
        print(obj.code)
        print(obj.signal)
        print(obj.stdout)
        print(obj.stderr)
    end

    vim.api.nvim_create_user_command("RunCompiledJava", function(opts)
        local args = vim.split(opts.args, " ")
        -- vim.print(opts.nargs)
        -- vim.print(opts.args)

        local num_args = #args

        -- vim.print("Number of arguments passed: " .. num_args)
        -- vim.print("First arg: " .. args[1])

        if num_args == 1 then
            vim.system({ "java", "-cp", "bin", buf_package_name .. "." .. buf_class_name }, { text = true }, on_exit)
            return
        end

        local bin_path = args[1] or "bin" -- Default to "bin" if not provided
        local class = args[2] or buf_class_name -- Use buffer class name if not provided
        local package = args[3] or buf_package_name -- Use buffer package name if not provided

        local class_path = class

        if package then
            class_path = package .. "." .. class
        end

        vim.system({ "java", "-cp", bin_path, class_path }, { text = true }, on_exit)
    end, { desc = "Run this class compiled java", nargs = "*", force = true })

    -- vim.cmd({ cmd = "RunCompiledJava", args = { "bin", buf_class_name, buf_package_name } })
end

return M
