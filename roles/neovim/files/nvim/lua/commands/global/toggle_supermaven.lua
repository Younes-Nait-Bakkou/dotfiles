local M = {}

function M.setup()
    local state = require("utils.state")

    vim.api.nvim_create_user_command("ToggleSupermaven", function()
        state.toggle("supermaven")
        vim.notify("Please restart nvim to apply changes for Supermaven.", vim.log.levels.WARN, { title = "Supermaven" })
    end, {
        desc = "Toggle Supermaven on/off (requires restart)",
    })
end

return M