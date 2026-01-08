return {
    "Kurama622/llm.nvim",
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
        require("configs.llm-nvim").setup()
    end,
    keys = {
        { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
    },
}
