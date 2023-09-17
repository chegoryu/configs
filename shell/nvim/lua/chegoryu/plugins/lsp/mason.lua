local config = require("chegoryu.core.config")

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

local language_servers = {
    -- C/C++.
    "clangd",

    -- CMake.
    "cmake",

    -- Python.
    "pyright",

    -- Go.
    "gopls",

    -- Rust.
    "rust_analyzer",

    -- Lua.
    "lua_ls",

    -- Java.
    "jdtls",

    -- Kotlin.
    "kotlin_language_server",

    -- Html.
    "html",

    -- CSS.
    "cssls",
    "tailwindcss",

    -- UI Overall.
    "emmet_ls",

    -- TypeScript.
    "tsserver",

    -- Vue.
    "vuels",
}

local formatters_and_linters = {
    -- C/C++
    "clang_format",

    -- CMake.
    "cmake_format",

    -- Python.
    "black",

    -- Go.
    "golangci_lint",

    -- Rust.
    "rustfmt",

    -- Lua.
    "stylua",

    -- Kotlin.
    "ktlint",

    -- UI.
    "prettier",
    "eslint_d",
}

if not config.IS_PINELY then
    -- C#.
    table.insert(language_servers, "omnisharp")
    table.insert(formatters_and_linters, "csharpier")
end

mason_lspconfig.setup({
    -- List of servers for mason to install.
    ensure_installed = language_servers,

    -- Auto-install configured servers (with lspconfig).
    -- NB: Not the same as ensure_installed.
    automatic_installation = true,
})

mason_null_ls.setup({
    -- List of formatters & linters for mason to install.
    ensure_installed = formatters_and_linters,
    -- Auto-install configured formatters & linters (with null-ls).
    -- NB: Not the same as ensure_installed.
    automatic_installation = true,
})
