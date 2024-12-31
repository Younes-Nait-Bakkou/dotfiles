local M = {}

function M.setup(bufnr)
    local params = vim.lsp.util.make_position_params()

    local lsp_response, err = vim.lsp.buf_request_sync(bufnr, "textDocument/documentSymbol", params, 10000)

    if err then
        vim.print("Error querying LSP:", err)
        return
    end

    if not lsp_response then
        vim.print("No response from LSP.")
        return
    end

    -- Process the results from all LSP clients
    for client_id, response in pairs(lsp_response) do
        if response.error then
            vim.print("Error from client " .. client_id .. ": " .. response.error.message)
            return
        end

        -- Process symbols
        for _, symbol in ipairs(response.result or {}) do
            if symbol.kind == 4 then -- Symbol kind of package is 4
                M.package_name = symbol.name
                print("package", symbol.name)
            elseif symbol.kind == 5 then -- Symbol kind of class is 5
                M.class_name = symbol.name
                print("class_name", symbol.name)
            end
        end
    end
end

return M
