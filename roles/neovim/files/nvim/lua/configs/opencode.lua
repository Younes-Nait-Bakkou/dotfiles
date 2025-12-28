local M = {}

M.setup = function()
    local wk = require("which-key")

    vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `vim.g.opencode_opts.auto_reload`
    vim.opt.autoread = true

    -- Opencode
    wk.add({
        { "<leader>o", group = " Opencode" },
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            desc = "Ask about this",
            mode = { "n", "x" },
        },
        {
            "<leader>o+",
            function()
                require("opencode").prompt("@this")
            end,
            desc = "Add this",
            mode = { "n", "x" },
        },
        {
            "<leader>os",
            function()
                require("opencode").select()
            end,
            desc = "Select prompt",
            mode = { "n", "x" },
        },
        {
            "<leader>ot",
            function()
                require("opencode").toggle()
            end,
            desc = "Toggle embedded",
        },
        {
            "<leader>oc",
            function()
                require("opencode").command()
            end,
            desc = "Select command",
        },
        {
            "<leader>on",
            function()
                require("opencode").command("session_new")
            end,
            desc = "New session",
        },
        {
            "<leader>oi",
            function()
                require("opencode").command("session_interrupt")
            end,
            desc = "Interrupt session",
        },
        {
            "<leader>oA",
            function()
                require("opencode").command("agent_cycle")
            end,
            desc = "Cycle selected agent",
        },
        {
            "<S-C-u>",
            function()
                require("opencode").command("messages_half_page_up")
            end,
            desc = "Messages half page up",
        },
        {
            "<S-C-d>",
            function()
                require("opencode").command("messages_half_page_down")
            end,
            desc = "Messages half page down",
        },
    })
end

return M
