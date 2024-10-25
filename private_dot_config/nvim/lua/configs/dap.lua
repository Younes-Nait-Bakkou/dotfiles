local map = vim.keymap.set
local dap = require("dap")
local save_expressions = require("utils.save_dap_expressions").save_expressions
local load_expressions = require("utils.load_dap_expressions").load_expressions

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle DAP Breakpoint" })

map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue DAP" })

map("n", "<F9>", dap.continue)
map("n", "<F8>", dap.step_over)
map("n", "<F10>", dap.step_into)
map("n", "<F12>", dap.step_out)
map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

map("n", "<leader>db", dap.toggle_breakpoint)

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
    "<leader>ds",
    ":lua require('utils.save_dap_expressions').save_expressions()<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>dl",
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
