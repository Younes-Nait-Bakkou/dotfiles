-- =============================================================================
-- 1. Configuration & Providers
-- =============================================================================
local M = {}

-- Gemini Model Selection
local GeminiModels = {
    PRO = "gemini-2.5-pro",
    FLASH = "gemini-2.5-flash",
    FLASH_LITE = "gemini-2.5-flash-lite",
}

local active_model = GeminiModels.FLASH_LITE -- Change this to select a different model

-- Define your available providers here
local providers = {
    gemini = function(prompt)
        -- The specific command for your Gemini CLI
        -- We use shellescape to safely pass the entire prompt + diff as one argument
        local safe_prompt = vim.fn.shellescape(prompt)
        local cmd = "gemini -p " .. safe_prompt .. " -m " .. active_model

        -- Execute and capture output
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        -- Clean up CLI specific noise (like "Loaded cached credentials")
        if result then
            result = result:gsub("Loaded cached credentials%.", "")
            result = result:gsub("Okay, I'm ready for your first command", "")
            result = result:gsub("```Line", ""):gsub("```", "")
            result = result:gsub("^%s*", ""):gsub("%s*$", "")
        end
        return result
    end,

    -- Example: You could easily add 'ollama' or 'openai' here in the future
    openai = function(prompt)
        -- implementation for openai...
    end,
}

-- Choose which provider to use
local active_provider = providers.gemini

-- =============================================================================
-- 2. Core Logic (Agnostic)
-- =============================================================================
function M.generate_commit_message()
    -- A. Get the staged diff
    -- We use git diff --cached so we get the exact changes staged for commit
    local handle = io.popen("git diff --cached")
    local diff_content = handle:read("*a")
    handle:close()

    if not diff_content or diff_content == "" then
        print("AI Commit: No staged changes found.")
        return
    end

    -- B. Build the generic prompt
    local system_instruction =
        "You are an expert developer. Write a concise Git commit message following the Conventional Commits specification (feat:, fix:, chore:, etc). Do not use markdown code blocks. Just the message."
    local full_prompt = system_instruction .. "\n\nDiff:\n" .. diff_content

    print("Asking AI for commit message...")

    -- C. Call the provider (The agnostic part)
    local result = active_provider(full_prompt)

    -- D. Paste into the buffer
    if result and result ~= "" then
        local lines = vim.split(result, "\n")
        -- Insert at the top of the file (line 0) or at cursor
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    else
        print("AI returned no response.")
    end
end

-- =============================================================================
-- 3. Setup Autocommands
-- =============================================================================
-- This ensures the keymap 'gc' ONLY exists when you are actually writing a commit

local group = vim.api.nvim_create_augroup("AICommitGroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    group = group,
    callback = function()
        -- Map 'gc' locally to this buffer
        vim.keymap.set("n", "gc", function()
            M.generate_commit_message()
        end, {
            buffer = true,
            desc = "Generate AI Commit Message",
        })
        print("AI Commit: Press 'gc' to generate message")
    end,
})

return M

