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
                    id = "scopes",
                    size = 0.4,
                },
                {
                    id = "breakpoints",
                    size = 0.2,
                },
                {
                    id = "stacks",
                    size = 0.2,
                },
                {
                    id = "watches",
                    size = 0.2,
                },
            },
            position = "left",
            size = 35,
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.4,
                },
                {
                    id = "console",
                    size = 0.6,
                },
            },
            position = "bottom",
            size = 10,
        },
    },
})

dap.configurations.java = {
    {
        name = "Java: Debug Launch (2GB)",
        type = "java",
        request = "launch",
        vmArgs = "" .. "-Xmx2g",
    },
    {
        name = "Java: Debug Attach (8000)",
        type = "java",
        request = "attach",
        hostname = "127.0.0.1",
        port = 8000,
    },
    {
        name = "Java: Debug Attach (5005)",
        type = "java",
        request = "attach",
        hostname = "127.0.0.1",
        port = 5005,
    },
}

local map = vim.keymap.set

map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
-- map("n", "<leader>gb", dap.run_to_cursor)

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
-- dap.listeners.before.event_terminated.dapui_config = function()
--     vim.defer_fn(function()
--         dapui.close()
--     end, 10000)
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end
