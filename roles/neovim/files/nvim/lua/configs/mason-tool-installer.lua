require("mason-tool-installer").setup({
    ensure_installed = {
        "java-debug-adapter",
        "java-test",
    },
})
vim.api.nvim_command("MasonToolsInstall")
