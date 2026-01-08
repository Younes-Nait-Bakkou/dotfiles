-- require("configs.filetype-configs.htmldjango")
require("myplugins.floating-terminal")

local plugins = {}

local function add_plugin_from_file(module_name)
    local status_ok, plugin_table = pcall(require, module_name)
    if status_ok then
        table.insert(plugins, plugin_table)
    else
        vim.notify("Error loading plugin: " .. module_name, vim.log.levels.ERROR)
    end
end

-- Load all plugin files from lua/plugins/**/
local plugin_files = vim.fn.globpath(
    vim.fn.stdpath("config") .. "/lua/plugins",
    "**/*.lua",
    true,
    true
)

for _, file_path in ipairs(plugin_files) do
    if not file_path:find("init.lua") then
        local module_name = file_path:match(".+/lua/(.+).lua$")
        if module_name then
            add_plugin_from_file(module_name:gsub("/", "."))
        end
    end
end

return plugins
