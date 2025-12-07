local M = {} -- Create a table to hold your functions

function M.venv_python_path() -- Add 'M.' to make it part of the module
    local cwd = vim.loop.cwd()
    local where = M.venv_bin_detection("python") -- Call with 'M.'
    if where == "python" then
        return "/usr/bin/python"
    end
    return where
end

function M.venv_bin_detection(tool) -- Add 'M.' to make it part of the module
    local cwd = vim.loop.cwd()
    if vim.fn.executable(cwd .. "/.venv/bin/" .. tool) == 1 then
        return cwd .. "/.venv/bin/" .. tool
    end
    return tool
end

function M.file_exists(name) -- Add 'M.' to make it part of the module
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function M.is_wsl()
    local f = io.open("/proc/version", "r")
    if f then
        local content = f:read("*all")
        f:close()
        -- Check for 'Microsoft' string in /proc/version
        if content:match("Microsoft") or content:match("microsoft") then
            return true
        end
    end
    return false
end

return M
