require("nvchad.mappings")
-- add yours here
local wk = require("which-key")
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Lspsaga key mappings
wk.add({
    { "<leader>l", group = "Lspsaga" },
    { "<leader>lc", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
    { "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", desc = "Lsp GoTo Definition" },
    { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lsp Finder" },
    { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
    { "<leader>lp", "<cmd>Lspsaga preview_definition<cr>", desc = "Preview Definition" },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    { "<leader>ls", "<cmd>Lspsaga signature_help<cr>", desc = "Signature Help" },
    { "<leader>lw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Show Workspace Diagnostics" },
})

-- Define the marks plugin require statement as a variable for easy replacement
local marks_cmd = "<cmd>:lua require('marks')."

wk.add({
    -- Group for marks
    { "<leader>m", group = "Marks" },
    { "m,", marks_cmd .. "set_next()<cr>", desc = "Set next available lowercase mark" },
    { "m;", marks_cmd .. "toggle()<cr>", desc = "Toggle next available mark" },
    { "dm-", marks_cmd .. "delete_line()<cr>", desc = "Delete all marks on the current line" },
    { "dm<space>", marks_cmd .. "delete_buf()<cr>", desc = "Delete all marks in the current buffer" },
    { "m]", marks_cmd .. "next()<cr>", desc = "Move to next mark" },
    { "m[", marks_cmd .. "prev()<cr>", desc = "Move to previous mark" },
    { "m:", marks_cmd .. "preview()<cr>", desc = "Preview mark" },
    { "mx", marks_cmd .. "set()<cr>", desc = "Set letter mark" },
    { "dmx", marks_cmd .. "delete()<cr>", desc = "Delete letter mark" },

    -- List Marks
    { "<leader>mlb", "<cmd>MarksListBuf<cr>", desc = "List all marks in current buffer" },
    { "<leader>mla", "<cmd>MarksListAll<cr>", desc = "List all marks in the buffers" },
    { "<leader>mlg", "<cmd>MarksListGlobal<cr>", desc = "List all global marks in the buffers" },

    -- Bookmarks
    { "m0", marks_cmd .. "set_bookmark(0)<cr>", desc = "Set bookmark group 0" },
    { "m1", marks_cmd .. "set_bookmark(1)<cr>", desc = "Set bookmark group 1" },

    -- Repeat for bookmark groups as needed
    { "dm0", marks_cmd .. "delete_bookmark(0)<cr>", desc = "Delete bookmarks from group 0" },
    { "dm1", marks_cmd .. "delete_bookmark(1)<cr>", desc = "Delete bookmarks from group 1" },

    { "m}", marks_cmd .. "next_bookmark()<cr>", desc = "Move to next bookmark of the same type" },
    { "m{", marks_cmd .. "prev_bookmark()<cr>", desc = "Move to previous bookmark of the same type" },
    { "dm=", marks_cmd .. "delete_bookmark()<cr>", desc = "Delete bookmark under cursor" },
    { "a", marks_cmd .. "annotate()<cr>", desc = "Annotate a bookmark" },
})
--
-- vim.api.nvim_create_autocmd({ "FileType", "BufReadPost", "BufEnter" }, {
--     pattern = "*.html",
--     callback = function()
--         if vim.bo.filetype == "htmldjango" then
--             vim.bo.commentstring = "{#-- %s --#}"
--         end
--     end,
-- })
