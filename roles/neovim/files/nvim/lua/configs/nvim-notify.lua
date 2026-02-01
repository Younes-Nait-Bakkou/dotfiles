require("notify").setup({
    -- 1. Filtering & Timing
    level = vim.log.levels.INFO, -- Ignore "Trace" or "Debug" noise
    timeout = 3000, -- 2 seconds (snappy)

    -- 2. Size Constraints (Key for making it "smaller")
    max_width = 30, -- Maximum columns
    max_height = 10, -- Maximum lines
    minimum_width = 10, -- Prevents it from being too thin

    -- 3. Visuals & Animation
    render = "wrapped-default", -- The most minimal built-in style
    stages = "static", -- No animation (instant appearance)
    fps = 30, -- Lower CPU usage (irrelevant with "static" but good to set)
    top_down = true, -- true for top-down, false for bottom-up
    background_colour = "Normal", -- Matches your main window background

    -- 4. Icons & Formats
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
    time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
    },

    -- 5. Window Callbacks (Advanced)
    on_open = function(win)
        -- Optional: Set transparency or specific window options here
        vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
    on_close = function(win)
        -- Cleanup if necessary
    end,
})
