local telescope = require("telescope")

telescope.setup({
    pickers = {
        find_files = {
            theme = "ivy",
        },
        live_grep = {
            theme = "ivy",
        },
        -- find_command = {
        --     theme = "ivy",
        -- },
        -- buffers = {
        --     sort_lastused = true,
        --     mappings = {
        --         i = {
        --             ["<c-d>"] = actions.delete_buffer,
        --             ["<c-x>"] = actions.cycle_buffers,
        --         },
        --     },
        --     layout_config = {
        --         horizontal = {
        --             prompt_position = "top",
        --             preview_width = -2.55,
        --             results_width = -2.8,
        --         },
        --         vertical = {
        --             mirror = false,
        --         },
        --         width = -2.87,
        --         height = -2.80,
        --         preview_cutoff = 118,
        --     },
        -- },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("git_file_history")
