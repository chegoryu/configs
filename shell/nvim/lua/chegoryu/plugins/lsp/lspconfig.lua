local config = require("chegoryu.core.config")

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

local rust_tools_status, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status then
    return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
    return
end

local keymap = vim.keymap

-- Enable keybinds only for when lsp server available.
local on_attach = function(client, bufnr)
    -- Keybind options.
    local opts = { silent = true, buffer = bufnr }

    -- Set keybinds.

    -- Show definition, references.
    keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)
    -- Go to declaration.
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- See definition and make edits in window.
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    -- Go to implementation.
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- See available code actions.
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    -- Smart rename.
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    -- Show diagnostics for line.
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    -- Show diagnostics for cursor.
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    -- Jump to previous diagnostic in buffer.
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    -- Jump to next diagnostic in buffer.
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    -- Show documentation for what is under cursor.
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    -- See outline on right hand side.
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
end

-- Used to enable autocompletion (assign to every lsp server config).
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter).
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Configure clangd server.
local clangd_capabilities = cmp_nvim_lsp.default_capabilities()
clangd_capabilities.offsetEncoding = "utf-8"

lspconfig["clangd"].setup({
    capabilities = clangd_capabilities,
    on_attach = on_attach,

    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--log=info",
        "--pretty",
        "-j=8",
    },
})

-- Configure cmake server.
lspconfig["cmake"].setup({
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
if config.IS_PINELY then
    pyright_options.settings.python.pythonPath = "/usr/bin/twix-python"
end

lspconfig["pyright"].setup(pyright_options)

-- Configure go server.
lspconfig["gopls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure rust server.
rust_tools.setup({
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        capabilities = capabilities,
        on_attach = on_attach,

        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})

-- Configure lua server.
lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,

    settings = {
        Lua = {
            -- Make the language server recognize "vim" global.
            diagnostics = {
                globals = { "vim" },
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
lspconfig["omnisharp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,

    cmd = {
        "omnisharp",
    },
})

-- Configure java server.
lspconfig["jdtls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure kotlin server.
lspconfig["kotlin_language_server"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure html server.
lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure css server.
lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure tailwindcss server.
lspconfig["tailwindcss"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure emmet (UI) server.
lspconfig["emmet_ls"].setup({
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
typescript.setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
    },
})

-- Configure vue server.
lspconfig["vuels"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
