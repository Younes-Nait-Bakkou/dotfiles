local dap = require("dap")
local utils = require("utils")
local utils = require("dap.utils")

require("dap").set_log_level("TRACE")
-- Adapter: pwa-node
dap.adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
        command = "node",
        args = {
            vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
            "${port}",
        },
    },
}

-- Adapter: pwa-chrome
-- dap.adapters["pwa-chrome"] = {
--     type = "server",
--     host = "127.0.0.1",
--     port = "${port}",
--     executable = {
--         command = "node",
--         args = {
--             vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
--             "${port}",
--         },
--     },
-- }
--
if not dap.adapters["node"] then
    dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
            config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
        else
            cb(nativeAdapter)
        end
    end
end

local js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
}

local function set_node_dap()
    for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {

            {
                type = "pwa-node",
                request = "attach",
                name = "Attach to Node.js",
                port = 9229,
                address = "127.0.0.1",
                localRoot = vim.fn.getcwd(),
                remoteRoot = "file:///home/flamer/Desktop/codes/Projects/DwiLive/server",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },

            {
                type = "pwa-node",
                request = "attach",
                name = "Attach to process ID",
                processId = utils.pick_process,
                cwd = "${workspaceFolder}",
                runtimeExecutable = "tsx",
            },

            {
                type = "pwa-node",
                request = "attach",
                name = "Attach to Port 9229 (WSL)",
                port = 9229,
                cwd = "${workspaceFolder}",
                rootPath = "${workspaceFolder}",
                sourceMaps = true,
                sourceMapPathOverrides = {
                    ["file://${workspaceFolder}/*"] = "${workspaceFolder}/*",
                },
            },

            {
                type = "node",
                request = "launch",
                name = "pick script (pnpm)",
                runtimeExecutable = "pnpm",
                runtimeArgs = { "run", "dev" },
                cwd = "${workspaceFolder}",
            },

            -- {
            --     type = "pwa-chrome",
            --     request = "launch",
            --     name = "Launch & Debug Chrome",
            --     url = function()
            --         local co = coroutine.running()
            --         return coroutine.create(function()
            --             vim.ui.input({
            --                 prompt = "Enter URL: ",
            --                 default = "http://127.0.0.1:3000",
            --             }, function(url)
            --                 if url == nil or url == "" then
            --                     return
            --                 else
            --                     coroutine.resume(co, url)
            --                 end
            --             end)
            --         end)
            --     end,
            --     webRoot = vim.fn.getcwd(),
            --     protocol = "inspector",
            --     sourceMaps = true,
            --     userDataDir = false,
            -- },
            {
                name = "----- ↓ launch.json configs ↓ -----",
                type = "",
                request = "launch",
            },
        }
    end

    if vim.fn.filereadable(".vscode/launch.json") == 1 then
        require("dap.ext.vscode").load_launchjs(nil, {
            ["node"] = js_based_languages, -- <--- ADD THIS LINE!
            ["pwa-node"] = js_based_languages,
            ["pwa-chrome"] = js_based_languages,
            ["chrome"] = js_based_languages,
        })
    end
end

set_node_dap()

vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
    callback = set_node_dap,
})
