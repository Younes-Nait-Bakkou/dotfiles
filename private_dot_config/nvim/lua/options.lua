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
