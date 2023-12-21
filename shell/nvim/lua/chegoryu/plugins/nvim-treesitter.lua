return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup({
                -- Enable syntax highlighting.
                highlight = {
                    enable = true,
                },
                -- Enable indentation.
                indent = { enable = true },
                -- Enable autotagging.
                autotag = {
                    enable = true,
                },
                -- Ensure these language parsers are installed.
                ensure_installed = {
                    "c",
                    "cpp",

                    "python",

                    "go",
                    "gosum",
                    "gomod",

                    "rust",

                    "lua",

                    "java",
                    "kotlin",

                    "proto",

                    "bash",

                    "json",
                    "yaml",

                    "latex",
                    "markdown",
                    "markdown_inline",

                    "vim",
                    "dockerfile",
                    "gitignore",

                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "css",
                    "prisma",
                    "svelte",
                    "graphql",
                    "query",
                },
                -- Auto install above language parsers.
                auto_install = true,
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })

            -- Enable nvim-ts-context-commentstring plugin for commenting tsx and jsx.
            local ts_context_commentstring = require("ts_context_commentstring")
            ts_context_commentstring.setup({})
        end,
    },
}
