return {
    -- Managing & installing lsp servers, linters & formatters.
    "mason-org/mason.nvim",
    dependencies = {
        -- LSP config must be loaded before Mason to ensure that all LSPs are configured before being enabled via mason.
        "neovim/nvim-lspconfig",
        -- Bridges gap b/w mason & lspconfig.
        "mason-org/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local config = require("chegoryu.core.config")

        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_null_ls = require("mason-null-ls")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local language_servers = {
            -- Bazel.
            "bzl",

            -- C/C++.
            "clangd",

            -- CMake.
            "cmake",

            -- Python.
            "pyright",

            -- Go.
            "gopls",

            -- Rust.
            -- NB: rustaceanvim manages rust-analyzer.
            -- "rust_analyzer",

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
            "ts_ls",

            -- Vue.
            "vuels",
        }

        local formatters_and_linters = {
            -- Bazel.
            "buildifier",

            -- C/C++
            "clang_format",

            -- CMake.
            "cmake_format",

            -- Python.
            "black",

            -- Go.
            "golangci_lint",

            -- Rust.
            -- NB: rustfmt must be installed via rustup.
            -- "rustfmt",

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
    end,
}
