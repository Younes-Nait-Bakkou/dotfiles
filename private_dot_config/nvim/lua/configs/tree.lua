-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local wk = require("which-key")

require("nvim-tree").setup({

    update_cwd = true,
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    view = {
        side = "left",
        adaptive_size = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = true,
    },
    renderer = {
        highlight_git = "icon",
    },
    diagnostics = {
        enable = true,
    },
})

wk.add({
    { "<leader>t", group = "NvimTree" },
    { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim tree window" },
}) -- custom mappings
