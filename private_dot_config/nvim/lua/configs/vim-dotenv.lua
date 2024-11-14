vim.cmd([[
augroup LoadDotenv
    autocmd!
    autocmd VimEnter * if exists(':Dotenv') | exe 'Dotenv! ./.env' | endif
augroup END
]])

print(os.getenv("DEV_DB_URL"))
