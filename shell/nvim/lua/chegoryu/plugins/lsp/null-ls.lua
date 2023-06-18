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
        formatting.clang_format.with({
            filetypes = {
                "c",
                "cpp",
                "c",
                "h",
            },
        }),

        formatting.cmake_format,

        formatting.black.with({
            extra_args = {
                "--line-length=120",
                "--skip-string-normalization",
            },
        }),

        formatting.gofmt,

        formatting.rustfmt.with({
            extra_args = {
                "--edition=2021",
            },
        }),

        formatting.stylua,

        formatting.csharpier,

        formatting.ktlint,
    },

    on_attach = function(current_client, bufnr)
        local function format_code()
            vim.lsp.buf.format({
                filter = function(client)
                    -- Only use null-ls for formatting instead of lsp server.
                    return client.name == "null-ls"
                end,
                bufnr = bufnr,
                timeout_ms = 30000,
            })
        end

        if current_client.supports_method("textDocument/formatting") then
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

        if current_client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("v", "<leader>cf", format_code, { silent = true, buffer = bufnr })
        end
    end,
})
