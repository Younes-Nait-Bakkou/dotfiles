require("nvchad.options")
local is_wsl = require("utils").is_wsl

-- add yours here!

local o = vim.o
--
-- o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.scrolloff = 10
vim.g.material_style = "darker"
-- o.termguicolors = true

-- Enable Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Enable neovim built-in spell check
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.cmd([[
    augroup PythonSpellCheck
        autocmd!
        autocmd FileType python syntax match SpellCheck /\w\+/ containedin=ALL
    augroup END
]])

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "python",
--     callback = function()
--         vim.cmd("setlocal spell") -- Ensure spell check is enabled
--         vim.api.nvim_set_hl(0, "@variable", { spell = true })
--         vim.api.nvim_set_hl(0, "@function", { spell = true })
--         vim.api.nvim_set_hl(0, "@type", { spell = true }) -- For class names
--     end
-- })

vim.o.updatetime = 250
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Detect WSL by checking /proc/version

if is_wsl() then
    vim.g.clipboard = {
        name = "xsel",
        copy = {
            ["+"] = "xsel --nodetach -i -b",
            ["*"] = "xsel --nodetach -i -p",
        },
        paste = {
            ["+"] = "xsel -o -b",
            ["*"] = "xsel -o -p",
        },
        cache_enabled = 1,
    }
    vim.opt.clipboard = "unnamedplus"
else
    vim.g.clipboard = {
        name = "unnamedplus",
        copy = {
            ["+"] = "xclip -selection clipboard -i",
            ["*"] = "xclip -selection clipboard -i",
        },
        paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection clipboard -o",
        },
        cache_enabled = 0,
    }
    vim.opt.clipboard = "unnamedplus"
end

vim.filetype.add({
    extension = {
        conf = "conf",
    },
    filename = {
        ["dunstrc"] = "ini",
        ["hyprland.conf"] = "hyprlang",
    },
    pattern = {
        -- Waybar config is JSONC (JSON with comments)
        [".*/waybar/config"] = "jsonc",
        [".*/waybar/style.css"] = "css",

        -- Wofi config is essentially INI/Key-Value
        [".*/wofi/config"] = "ini",
        [".*/wofi/style.css"] = "css",
    },
})
