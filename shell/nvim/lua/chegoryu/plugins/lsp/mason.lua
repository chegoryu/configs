local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    return
end

mason.setup()

mason_lspconfig.setup({
    -- List of servers for mason to install.
    ensure_installed = {
        -- C/C++
        "clangd",

        -- CMake.
        "cmake",

        -- Python.
        "pylsp",

        -- Go.
        "gopls",

        -- Rust.
        "rust_analyzer",

        -- Lua.
        "lua_ls",

        -- C#.
        "omnisharp",

        -- Java.
        "jdtls",

        -- Kotlin.
        "kotlin_language_server",
    },
    -- Auto-install configured servers (with lspconfig).
    -- NB: Not the same as ensure_installed.
    automatic_installation = true,
})

mason_null_ls.setup({
    -- List of formatters & linters for mason to install.
    ensure_installed = {
        "stylua",
    },
    -- Auto-install configured formatters & linters (with null-ls).
    automatic_installation = true,
})
