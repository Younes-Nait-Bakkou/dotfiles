local session_path = vim.fn.stdpath("data") .. "/sessions/"

if vim.fn.empty(vim.fn.glob(session_path)) > 0 then
    vim.fn.mkdir(session_path, "p")
end

require("nvim-possession").setup({
    sessions = {
        sessions_path = vim.fn.stdpath("data") .. "/sessions/",
        sessions_variable = "session",
        sessions_icon = "📌",
        sessions_prompt = "sessions:",
    },

    autoload = false, -- whether to autoload sessions in the cwd at startup
    autosave = true, -- whether to autosave loaded sessions before quitting
    autoswitch = {
        enable = true, -- whether to enable autoswitch
    },

    save_hook = nil, -- callback, function to execute before saving a session
    -- useful to update or cleanup global variables for example
    post_hook = nil, -- callback, function to execute after loading a session
    -- useful to restore file trees, file managers or terminals
    -- function()
    --     require('FTerm').open()
    --     require('nvim-tree').toggle(false, true)
    -- end

    fzf_winopts = {
        hl = { normal = "Normal" },
        border = "rounded",
        height = 0.5,
        width = 0.25,
        preview = {
            horizontal = "down:40%",
        },
    },
})

local possession = require("nvim-possession")

vim.keymap.set("n", "<leader>sl", function()
    possession.list()
end)
vim.keymap.set("n", "<leader>sn", function()
    possession.new()
end)
vim.keymap.set("n", "<leader>su", function()
    possession.update()
end)
vim.keymap.set("n", "<leader>sd", function()
    possession.delete()
end)
