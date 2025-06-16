return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local config = require("chegoryu.core.config")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Enable keybinds only for when lsp server available.
        local on_attach = function(client, bufnr)
            local keymap = vim.keymap

            -- Keybind options.
            local opts = { silent = true, buffer = bufnr }

            -- Set keymaps.

            opts.desc = "Show LSP references."
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Show definition, references."
            keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)

            opts.desc = "Go to declaration."
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "See definition and make edits in window."
            keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

            opts.desc = "Go to implementation."
            keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

            opts.desc = "See available code actions."
            keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

            opts.desc = "Smart rename."
            keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

            opts.desc = "Show diagnostics for line."
            keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

            opts.desc = "Show diagnostics for cursor."
            keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

            opts.desc = "Go to previous diagnostic in buffer."
            keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

            opts.desc = "Go to next diagnostic in buffer."
            keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

            opts.desc = "Show documentation for what is under cursor."
            keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

            opts.desc = "Toggle outline."
            keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

            opts.desc = "Restart LSP."
            keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
        end

        -- Used to enable autocompletion (assign to every lsp server config).
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter).
        local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Enable inline diagnostics.
        vim.diagnostic.config({ virtual_text = true })

        -- Try our best to pass common configuration for all LSP servers.
        -- This is not enough because some plugins try to override on_attach with their own and for important plugins
        -- we need to force our own on_attach, so this section is copypasted into all important LSPs.
        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure clangd server.
        local clangd_capabilities = cmp_nvim_lsp.default_capabilities()
        clangd_capabilities.offsetEncoding = "utf-8"

        vim.lsp.config("clangd", {
            capabilities = clangd_capabilities,
            on_attach = on_attach,

            cmd = {
                config.CLANGD_PATH,
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--log=info",
                "--pretty",
                "-j=8",
            },
        })

        -- Configure cmake server.
        vim.lsp.config("cmake", {
            capabilities = capabilities,
            on_attach = on_attach,

            filetypes = {
                "CMakeLists.txt",
                "cmake",
            },
        })

        -- Configure python server.
        local pyright_options = {
            capabilities = capabilities,
            on_attach = on_attach,

            settings = {
                python = {
                    analysis = {
                        autoImportCompletions = true,
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        typeCheckingMode = "strict",
                        useLibraryCodeForTypes = true,

                        diagnosticSeverityOverrides = {
                            analyzeUnannotatedFunctions = true,

                            enableTypeIgnoreComments = true,

                            strictDictionaryInference = true,
                            strictListInference = true,
                            strictParameterNoneValue = true,
                            strictSetInference = true,

                            reportAssertAlwaysTrue = "warning",
                            reportCallInDefaultInitializer = "none",
                            reportConstantRedefinition = "warning",
                            reportDeprecated = "warning",
                            reportDuplicateImport = "error",
                            reportFunctionMemberAccess = "error",
                            reportGeneralTypeIssues = "error",
                            reportImplicitOverride = "none",
                            reportImplicitStringConcatenation = "none",
                            reportImportCycles = "warning",
                            reportIncompatibleMethodOverride = "error",
                            reportIncompatibleVariableOverride = "error",
                            reportIncompleteStub = "none",
                            reportInconsistentConstructor = "error",
                            reportInvalidStringEscapeSequence = "error",
                            reportInvalidStubStatement = "none",
                            reportInvalidTypeVarUse = "error",
                            reportMatchNotExhaustive = "error",
                            reportMissingImports = "error",
                            reportMissingModuleSource = "error",
                            reportMissingParameterType = "error",
                            reportMissingSuperCall = "none",
                            reportMissingTypeArgument = "none",
                            reportMissingTypeStubs = "none",
                            reportOptionalCall = "error",
                            reportOptionalContextManager = "error",
                            reportOptionalIterable = "error",
                            reportOptionalMemberAccess = "error",
                            reportOptionalOperand = "error",
                            reportOptionalSubscript = "error",
                            reportOverlappingOverload = "error",
                            reportPrivateImportUsage = "none",
                            reportPrivateUsage = "none",
                            reportPropertyTypeMismatch = "warning",
                            reportSelfClsParameterName = "error",
                            reportShadowedImports = "warning",
                            reportTypeCommentUsage = "error",
                            reportTypedDictNotRequiredAccess = "error",
                            reportUnboundVariable = "error",
                            reportUndefinedVariable = "error",
                            reportUnknownArgumentType = "none",
                            reportUnknownLambdaType = "none",
                            reportUnknownMemberType = "none",
                            reportUnknownParameterType = "none",
                            reportUnknownVariableType = "none",
                            reportUnnecessaryCast = "warning",
                            reportUnnecessaryComparison = "none",
                            reportUnnecessaryContains = "warning",
                            reportUnnecessaryIsInstance = "none",
                            reportUnsupportedDunderAll = "warning",
                            reportUntypedBaseClass = "warning",
                            reportUntypedClassDecorator = "none",
                            reportUntypedFunctionDecorator = "none",
                            reportUntypedNamedTuple = "none",
                            reportUnusedClass = "error",
                            reportUnusedCoroutine = "error",
                            reportUnusedExpression = "error",
                            reportUnusedFunction = "error",
                            reportUnusedImport = "error",
                            reportUnusedVariable = "error",
                            reportWildcardImportFromLibrary = "error",
                        },
                    },
                },
            },
        }

        if config.PYTHON_PATH ~= nil then
            pyright_options.settings.python.pythonPath = config.PYTHON_PATH
        end
        if config.PYTHON_VENV_PATH ~= nil then
            pyright_options.settings.python.venvPath = config.PYTHON_VENV_PATH
        end

        vim.lsp.config("pyright", pyright_options)

        -- Configure go server.
        vim.lsp.config("gopls", {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd_env = {
                GOFLAGS = "-tags=e2e",
            },
        })

        -- Configure rust server.
        vim.lsp.config("rust-analyzer", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- It is almost impossible to write rust code without inlay hints.
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                on_attach(client, bufnr)
            end,

            cmd = {
                "rust-analyzer",
            },
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    checkOnSave = true,
                    files = {
                        watcher = "server",
                    },
                },
            },
            standalone = true,
        })
        -- Extra config for mrcjkb/rustaceanvim plugin.
        vim.g.rustaceanvim = {
            tools = {
                runnables = {
                    use_telescope = true,
                },
                inlay_hints = {
                    auto = true,
                    show_parameter_hints = true,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                },
            },
        }

        -- Configure lua server.
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_attach = on_attach,

            settings = {
                Lua = {
                    -- Make the language server recognize "vim" and "os" globals.
                    diagnostics = {
                        globals = {
                            "vim",
                            "os",
                        },
                    },
                    workspace = {
                        -- Make language server aware of runtime files.
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- Configure C# server.
        vim.lsp.config("omnisharp", {
            capabilities = capabilities,
            on_attach = on_attach,

            cmd = {
                "omnisharp",
            },
        })

        -- Configure java server.
        vim.lsp.config("jdtls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure kotlin server.
        vim.lsp.config("kotlin_language_server", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure html server.
        vim.lsp.config("html", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure css server.
        vim.lsp.config("cssls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure tailwindcss server.
        vim.lsp.config("tailwindcss", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure emmet (UI) server.
        vim.lsp.config("emmet_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "pug",
                "sass",
                "scss",
                "svelte",
                "typescriptreact",
                "vue",
            },
        })

        -- Configure typescript server.
        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure vue server.
        vim.lsp.config("vuels", {
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
