local M = {}

function M.setup()
    vim.api.nvim_create_user_command("QfRemove", function(opts)
        local idx = tonumber(opts.args)
        if not idx then
            print("Please provide a valid number")
            return
        end

        local qflist = vim.fn.getqflist()
        if idx < 1 or idx > #qflist then
            print("Index out of range")
            return
        end

        table.remove(qflist, idx)
        vim.fn.setqflist(qflist)
        print("Removed quickfix entry at index " .. idx)
    end, { nargs = 1 })
end

return M
