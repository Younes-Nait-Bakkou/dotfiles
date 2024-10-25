local dap = require("dap")
local dapui = require("dapui")

-- dapui.setup({
--     layouts = {
--         {
--             elements = {
--                 {
--                     id = "scopes",
--                     size = 0.25,
--                 },
--                 {
--                     id = "breakpoints",
--                     size = 0.25,
--                 },
--                 {
--                     id = "stacks",
--                     size = 0.25,
--                 },
--             },
--             position = "left",
--             size = 40,
--         },
--         {
--             elements = {
--                 {
--                     id = "console",
--                     size = 0.35,
--                 },
--                 {
--                     id = "watches",
--                     size = 0.65,
--                 },
--             },
--             position = "bottom",
--             size = 15,
--         },
--     },
-- })
--

dapui.setup({
    layouts = {
        {
            elements = {
                {
                    id = "watches", -- Expressions are handled here
                    size = 1, -- Take up all the space on the left
                },
            },
            position = "left",
            size = 40, -- Width of the left panel
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.4, -- Majority space for REPL
                },
                {
                    id = "console",
                    size = 0.6, -- Console gets smaller space
                },
            },
            position = "bottom",
            size = 10, -- Height of the bottom panel
        },
    },
})

local map = vim.keymap.set

map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
map("n", "<leader>gb", dap.run_to_cursor)

-- Eval var under cursor
map("n", "<space>?", function()
    require("dapui").eval(nil, { enter = true })
end, { desc = "Inspect cursor value" })

dap.listeners.after.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.after.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
