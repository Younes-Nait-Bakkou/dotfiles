require("nvchad.options")

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
