local dapPython = require("dap-python")
local dap = require("dap")
local pythonPath = require("utils").venv_python_path()
local globlaDebugpyPath = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

-- Python config
-- DO NOT FORGET TO INSTALL debugpy package if working on a python project with a venv
local set_python_dap = function()
    dapPython.setup() -- earlier, so I can setup the various defaults ready to be replaced
    dapPython.resolve_python = function()
        return pythonPath
    end

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = pythonPath,
        },
        {
            type = "python",
            request = "launch",
            name = "Django",
            program = vim.loop.cwd() .. "/manage.py",
            args = { "runserver", "8001", "--noreload" },
            justMyCode = false,
            django = true,
            console = "integratedTerminal",
            pythonPath = pythonPath,
        },
        {
            type = "python",
            request = "launch",
            name = "Django Command",
            program = vim.loop.cwd() .. "/manage.py",
            args = function()
                return { vim.fn.input("Command to run: ") }
            end,
            django = true,
            console = "integratedTerminal",
        },
        {
            type = "python",
            request = "launch",
            name = "Pytest: current file",
            module = "pytest",
            args = {
                "${file}",
                "-sv",
                "--log-cli-level=INFO",
                "--log-file=test_out.log",
            },
            console = "integratedTerminal",
            pythonPath = pythonPath,
        },
        {
            type = "python",
            request = "attach",
            name = "Attach remote",
            connect = function()
                return {
                    host = "127.0.0.1",
                    port = 5678,
                }
            end,
        },
        {
            type = "python",
            request = "launch",
            name = "Launch file with arguments",
            program = "${file}",
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " +")
            end,
            console = "integratedTerminal",
            pythonPath = pythonPath,
        },
    }

    -- Python debugpy config
    dap.adapters.python = {
        type = "executable",
        -- command = vim.fn.expand(globlaDebugpyPath),
        command = pythonPath,
        args = { "-m", "debugpy.adapter" },
    }
end

set_python_dap()
vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
    callback = function()
        set_python_dap()
    end,
})

local map = vim.keymap.set

map("n", "<leader>dpm", function()
    require("dap-python").test_method()
end, { desc = "Test current python method" })

map("n", "<leader>dpc", function()
    require("dap-python").test_class()
end, { desc = "Test current python class" })

map("v", "<leader>dps", function()
    require("dap-python").debug_selection()
end, { desc = "Debug selected" })
