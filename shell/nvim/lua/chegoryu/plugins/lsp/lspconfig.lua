local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

local keymap = vim.keymap

-- Enable keybinds only for when lsp server available.
local on_attach = function(client, bufnr)
    -- Keybind options.
    local opts = { silent = true, buffer = bufnr }

    -- Set keybinds.

    -- Show definition, references.
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
    -- Got to declaration.
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
lspconfig["clangd"].setup({
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--log=info",
        "--pretty",
        "-j=8",
    },
    on_attach = on_attach,
})

-- Configure cmake server.
lspconfig["cmake"].setup({
    capabilities = capabilities,
    filetypes = {
        "CMakeLists.txt",
        "cmake",
    },
    on_attach = on_attach,
})

-- Configure python server.
lspconfig["pylsp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure go server.
lspconfig["gopls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure rust server.
lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
    cmd = {
        "omnisharp",
    },
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure java server.
lspconfig["jdtls"].setup({
    cmd = {
        "/usr/local/bin/jdtls",
    },
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Configure kotlin server.
lspconfig["kotlin_language_server"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
