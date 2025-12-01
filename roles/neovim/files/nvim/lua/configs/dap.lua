local map = vim.keymap.set
local wk = require("which-key")
local dap = require("dap")
local save_expressions = require("utils.save_dap_expressions").save_expressions
local load_expressions = require("utils.load_dap_expressions").load_expressions

wk.add({
    { "<leader>d", group = "  Debug" },
    { "<leader>db", dap.toggle_breakpoint, desc = "Toggle DAP Breakpoint", mode = "n" },
    { "<leader>dr", dap.continue, desc = "Start or continue DAP", mode = "n" },
    { "<leader>ds", dap.step_over, desc = "Step over DAP", mode = "n" },
    { "<leader>dsi", dap.step_into, desc = "Step into DAP", mode = "n" },
    { "<leader>dso", dap.step_out, desc = "Step out DAP", mode = "n" },
    {
        "<leader>dB",
        function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set DAP Breakpoint",
        mode = "n",
    },
    { "<leader>dS", dap.close, desc = "Close DAP", mode = "n" },
    { "<leader>dR", dap.repl.toggle, desc = "Toggle DAP REPL", mode = "n" },
    { "<leader>dC", dap.run_to_cursor, desc = "Run to cursor DAP", mode = "n" },
    { "<leader>dD", dap.run_to_cursor, desc = "Run to cursor DAP", mode = "v" },
})

vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "ErrorMsg",
    linehl = "",
    numhl = "ErrorMsg",
})

vim.fn.sign_define("DapBreakpointCondition", {
    text = "⬤",
    texthl = "ErrorMsg",
    linehl = "",
    numhl = "SpellBad",
})

-- Save expressions when debugging ends
dap.listeners.after.event_terminated["save_expressions"] = function()
    save_expressions()
end

-- Load expressions when debugging starts
dap.listeners.before.event_initialized["load_expressions"] = function()
    load_expressions()
end

-- Optional keymaps for manual save/load
vim.api.nvim_set_keymap(
    "n",
    "<leader>dse",
    ":lua require('utils.save_dap_expressions').save_expressions()<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>dle",
    ":lua require('utils.load_dap_expressions').load_expressions()<CR>",
    { noremap = true, silent = true }
)

-- PHP adapter configuration, not needed for now
-- dap.adapters.php = {
--     type = 'executable',
--     command = 'nodejs',
--     args = {"/opt/vscode-php-debug/out/phpDebug.js"},
-- }
--
-- dap.configurations.php = {
--     {
--         type = 'php',
--         request = 'launch',
--         name = 'Listen for xdebug',
--         port = '9003',
--         log = false,
--         serverSourceRoot = '/srv/www/',
--         localSourceRoot = '/home/www/VVV/www/',
--     },
-- }
