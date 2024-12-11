local function get_env_var(var_name)
    local value = vim.fn.getenv(var_name)
    return value ~= "" and value or nil -- Return nil if the environment variable is not set
end

-- Define a list of database connections
local db_configs = {
    { name = "dev", env_var = "DEV_DB_URL" },
    { name = "staging", env_var = "STAGING_DB_URL" },
    { name = "production", env_var = "PRODUCTION_DB_URL" },
    { name = "test", env_var = "TEST_DB_URL" },
}

-- Initialize an empty dbs table
local dbs = {}
vim.g.db_ui_use_nerd_fonts = 1

-- Loop through the db_configs and check for valid environment variables
for _, db_config in ipairs(db_configs) do
    local db_url = get_env_var(db_config.env_var)

    if db_url ~= vim.NIL then
        local trimmed_db_url = db_url:match("^%s*(.-)%s*$")
        table.insert(dbs, { name = db_config.name, url = trimmed_db_url })
    end
end

-- Assign the dynamically built dbs table to vim.g.dbs for use in Dadbod UI
vim.g.dbs = dbs
