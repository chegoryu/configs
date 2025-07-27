return {
    -- Configure formatters & linters.
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Bridges gap b/w mason & null-ls.
        "jay-babu/mason-null-ls.nvim",

        -- Extra formatters & linters.
        "nvimtools/none-ls-extras.nvim",
        "davidmh/cspell.nvim",
    },
    config = function()
        local config = require("chegoryu.core.config")

        local null_ls = require("null-ls")

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        local function is_autoformatting_enabled(filetype)
            if config.FORMAT_ON_SAVE_ALL then
                return true
            end

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

        local black_options = {
            extra_args = {
                "--line-length=120",
                "--skip-string-normalization",
            },
        }
        if config.USE_BLACK_FROM_PYTHON then
            black_options.command = {
                config.PYTHON_PATH,
                "-m",
                "black",
            }
        end

        local clang_format_options = {
            filetypes = {
                "c",
                "cpp",
                "c",
                "h",
            },
        }
        if config.CLANG_FORMAT_PATH ~= nil then
            clang_format_options.command = config.CLANG_FORMAT_PATH
        end

        local golangci_lint_options = {
            condition = function(utils)
                return utils.root_has_file("go.mod")
            end,
        }
        if config.IS_PINELY then
            golangci_lint_options.condition = function()
                return true
            end
        end

        local formatting_rustfmt_source = require("none-ls.formatting.rustfmt")
        local diagnostics_eslint_d_source = require("none-ls.diagnostics.eslint_d")
        local cspell = require("cspell")

        local sources = {
            -- C/C++
            formatting.clang_format.with(clang_format_options),

            -- CMake.
            formatting.cmake_format,

            -- Python.
            formatting.black.with(black_options),

            -- Go.
            formatting.gofmt,
            diagnostics.golangci_lint.with(golangci_lint_options),

            -- Rust.
            formatting_rustfmt_source.with({
                extra_args = {
                    "--edition=2021",
                },
            }),

            -- Lua.
            formatting.stylua,

            -- Kotlin.
            formatting.ktlint,

            -- UI.
            formatting.prettier.with({
                extra_args = {
                    "--tab-width=4",
                },
            }),
            diagnostics_eslint_d_source.with({
                condition = function(utils)
                    return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")
                end,
            }),

            -- Spell.
            cspell.diagnostics.with({
                diagnostics_postprocess = function(d)
                    d.severity = vim.diagnostic.severity.HINT
                end,
                filetypes = {
                    "c",
                    "cpp",
                    "c",
                    "h",
                    "py",
                },
            }),
            cspell.code_actions,
        }

        -- This if is required because we do not want to install csharpier.
        -- Condition inside options allows to avoid running formatter, but null-ls will still try to install it.
        if not config.IS_PINELY then
            -- C#.
            table.insert(
                sources,
                formatting.csharpier.with({
                    condition = function()
                        return not config.IS_PINELY
                    end,
                })
            )
        end

        null_ls.setup({
            sources = sources,
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
                    vim.keymap.set("n", "<leader>cf", format_code, {
                        silent = true,
                        buffer = bufnr,
                        desc = "Format code in current buffer.",
                    })

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
                    vim.keymap.set("v", "<leader>cf", format_code, {
                        silent = true,
                        buffer = bufnr,
                        desc = "Format code in selected range.",
                    })
                end
            end,
        })
    end,
}
