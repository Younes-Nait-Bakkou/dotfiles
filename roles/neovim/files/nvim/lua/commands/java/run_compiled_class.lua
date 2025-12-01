local M = {}

function M.setup(bufnr)
    vim.api.nvim_create_user_command("RunCompiledJava", function(opts)
        local get_curr_java_file_info = require("commands.java.get_curr_java_file_info")
        get_curr_java_file_info.setup(0)

        local buf_package_name = get_curr_java_file_info.package_name
        local buf_class_name = get_curr_java_file_info.class_name

        local args = vim.split(opts.args, " ")
        local num_args = #args

        local with_terminal = false
        for _, arg in ipairs(args) do
            if arg == "with_terminal" then
                with_terminal = true
            end
        end

        -- Handle arguments for bin_path, class, and package
        local bin_path = "bin"
        local class = args[2] and args[2] ~= "with_terminal" and args[2] or buf_class_name
        local package = args[3] and args[3] ~= "with_terminal" and args[3] or buf_package_name

        vim.print("bin_path", bin_path)
        vim.print("class", class)
        vim.print("package", package)

        local class_path = class

        if package then
            class_path = package .. "." .. class
        end

        -- Define the Java command
        local java_command = "java -cp " .. bin_path .. " " .. class_path

        if with_terminal then
            -- Open the floating terminal if "with_terminal" is specified
            vim.print("with_terminal")
            require("myplugins.floating-terminal").open_floating_terminal({
                height = 20,
                width = 80,
                border = "double",
                persistent = true,
                cmds = { java_command },
                buf = bufnr,
            })
        else
            vim.print("with_not_terminal")
            -- Run the command normally
            --
            vim.cmd("botright vsplit | terminal " .. java_command)

            -- vim.system({ "java", "-cp", bin_path, class_path }, { text = true }, function(res)
            --     if res.code == 0 then
            --         print("Java program executed successfully!")
            --         print(res.stdout)
            --     else
            --         print("Error running Java program:")
            --         print(res.stderr)
            --     end
            -- end)
        end
    end, { desc = "Run this class compiled java", nargs = "*", force = true })

    -- vim.cmd({ cmd = "RunCompiledJava", args = { "bin", buf_class_name, buf_package_name } })
end

return M
