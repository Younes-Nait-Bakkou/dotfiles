local M = {}

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating_terimnal_info = {
        buf = -1,
        win = -1,
        term_id = -1,
    },
}

function M.open_floating_terminal(opts)
    -- Default options
    opts = opts or {}
    local height = opts.height or 20
    local width = opts.width or 80
    local border = opts.border or "rounded"
    local persistent = opts.persistent or false
    local cmds = opts.cmds or {}

    -- Calculate center of the screen
    local win_height = vim.o.lines
    local win_width = vim.o.columns
    local row = math.floor((win_height - height) / 2)
    local col = math.floor((win_width - width) / 2)

    -- Create a new buffer for the terminal

    local buf = nil

    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        style = "minimal",
        border = border,
    })

    local term_id = nil

    if not vim.api.nvim_buf_is_valid(opts.buf) then
        -- Start the terminal
        term_id = vim.fn.termopen(vim.o.shell, {
            on_exit = function(_, code)
                if code ~= 0 then
                    print("Terminal exited with code: " .. code)
                end
            end,
        })

        -- Run commands in the terminal consecutively
        for _, cmd in ipairs(cmds) do
            vim.fn.chansend(term_id, cmd .. "\n")
        end
    end

    -- Auto-close the window on <q> or <Esc>
    vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>q<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true })

    return { buf = buf, win = win, term_id = term_id }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating_terimnal_info.win) then
        state.floating_terimnal_info = M.open_floating_terminal({
            height = 20,
            width = 80,
            border = "double",
            persistent = true,
            buf = state.floating_terimnal_info.buf,
        })
    else
        vim.api.nvim_win_hide(state.floating_terimnal_info.win)
    end
end

vim.api.nvim_create_user_command("Floaterimnal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>ft", toggle_terminal)

return M
