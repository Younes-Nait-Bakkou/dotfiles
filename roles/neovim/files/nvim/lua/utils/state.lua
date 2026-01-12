local M = {}

function M.is_disabled(feature)
    local state_file = vim.fn.stdpath("data") .. "/feature_" .. feature .. "_disabled"
    return vim.fn.filereadable(state_file) > 0
end

function M.toggle(feature)
    local state_file = vim.fn.stdpath("data") .. "/feature_" .. feature .. "_disabled"
    if M.is_disabled(feature) then
        os.remove(state_file)
        vim.notify(feature .. " enabled", vim.log.levels.INFO, { title = "State" })
        return true -- now enabled
    else
        local f = io.open(state_file, "w")
        if f then
            f:close()
        end
        vim.notify(feature .. " disabled", vim.log.levels.INFO, { title = "State" })
        return false -- now disabled
    end
end

return M