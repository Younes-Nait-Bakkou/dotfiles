local iron = require("iron.core")
local pythonPath = require("utils").venv_python_path()

local function OpenPythonREPL()
    local choices = {
        django = { pythonPath, "manage.py", "shell" },
        python = { "python" },
    }

    local choice = vim.fn.input("Choose REPL... python(1) | django(2): ")

    -- Return the selected REPL config
    if choice == "1" then
        return choices.python
    elseif choice == "2" then
        return choices.django
    else
        print("Invalid choice! Defaulting to Python REPL.")
        return choices.python
    end
end

iron.setup({
    config = {
        repl_definition = {
            python = { command = OpenPythonREPL, format = require("iron.fts.common").bracketed_paste },
        },
        repl_open_cmd = "vertical botright 80 split",
    },
    keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sv",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_until_cursor = "<leader>su",
        send_mark = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mv",
        remove_mark = "<leader>md",
        cr = "<leader>sr",
        interrupt = "<leader>si",
        exit = "<leader>sq",
        clear = "<leader>cl",
    },
})
