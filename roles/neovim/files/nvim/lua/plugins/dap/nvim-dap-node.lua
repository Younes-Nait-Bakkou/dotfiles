return {
    "microsoft/vscode-js-debug",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    build = "npm install --legacy-peer-deps --no-save --ignore-scripts && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
    version = "1.*",
    dependencies = {
        "mfussenegger/nvim-dap",
        {
            "Joakker/lua-json5",
            build = "./install.sh",
        },
    },
    config = function()
        require("configs.dap-node")
    end,
}
