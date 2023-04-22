local setup, null_ls = pcall(require, "null-ls")
if not setup then
    return
end

local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function is_autoformatting_enabled(filetype)
    local filetype_whitelist = {
        "lua",
    }

    for _, filetype_from_whitelist in pairs(filetype_whitelist) do
        if filetype == filetype_from_whitelist then
            return true
        end
    end

    return false
end

null_ls.setup({
    sources = {
        formatting.gofmt,

        formatting.stylua,

        formatting.rustfmt.with({
            extra_args = {
                "--edition=2021",
            },
        }),
    },

    on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
            local function format_code()
                vim.lsp.buf.format({
                    filter = function(client)
                        -- Only use null-ls for formatting instead of lsp server.
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                })
            end

            vim.keymap.set("n", "<leader>cf", format_code, { silent = true, buffer = bufnr })

            -- Configure format on save.
            if is_autoformatting_enabled(vim.fn.getbufvar(bufnr, "&filetype")) then
                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = bufnr,
                })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = format_code,
                })
            end
        end
    end,
})
