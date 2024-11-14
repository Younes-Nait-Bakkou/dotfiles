-- This function will load your .env file
local function load_env()
    local env_file = ".env"
    local file = io.open(env_file, "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("([^=]+)=([^=]+)")
            if key and value then
                vim.fn.setenv(key, value) -- Set the environment variable
            end
        end
        file:close()
    else
        print("Could not open .env file.")
    end
end

-- Call the function to load the environment variables
load_env()

-- -- Access the environment variable
-- local dev_db_url = vim.fn.getenv("DEV_DB_URL")
--
-- if dev_db_url ~= "" then
--     print("DEV_DB_URL:", dev_db_url)
-- else
--     print("DEV_DB_URL is not set")
-- end
