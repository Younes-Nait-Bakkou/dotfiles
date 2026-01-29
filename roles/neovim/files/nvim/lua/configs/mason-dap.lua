require("mason-nvim-dap").setup({
    ensure_installed = { "python", "js-debug-adapter" },
    automatic_installation = { exclude = {} },
})
