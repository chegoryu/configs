local setup, null_ls = pcall(require, "null-ls")
if not setup then
    return
end

local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local bad_filetypes = {
    "go",
}
local function is_autoformatting_disabled(filetype)
    for _, bad_filetype in pairs(bad_filetypes) do
        if filetype == bad_filetype then
            return true
        end
    end

    return false
end

null_ls.setup({
    sources = {
        formatting.gofmt,

        formatting.stylua,
    },

    -- Configure format on save.
    on_attach = function(current_client, bufnr)
        local filetype = vim.fn.getbufvar(bufnr, "&filetype")

        if not is_autoformatting_disabled(filetype) and current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(client)
                            -- Only use null-ls for formatting instead of lsp server.
                            return client.name == "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
