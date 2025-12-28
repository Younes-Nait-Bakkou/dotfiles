require("gemini_cli").setup({
    -- Command that executes GeminiCLI
    gemini_cmd = "gemini",
    -- Command line arguments passed to gemini-cli
    args = {},
    -- Automatically reload buffers changed by GeminiCLI (requires vim.o.autoread = true)
    auto_reload = false,
    -- snacks.picker.layout.Config configuration
    picker_cfg = {
        preset = "vscode",
    },
    -- Other snacks.terminal.Opts options
    config = {
        os = { editPreset = "nvim-remote" },
        gui = { nerdFontsVersion = "3" },
    },
    win = {
        wo = { winbar = "GeminiCLI" },
        style = "gemini_cli",
        position = "right",
    },
})
