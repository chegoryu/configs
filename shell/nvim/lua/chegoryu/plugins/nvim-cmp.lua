return {
    -- Completion plugin.
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Source for text in buffer.
        "hrsh7th/cmp-buffer", -- source for text in buffer
        -- Source for file system paths.
        "hrsh7th/cmp-path",
        -- Snippet engine.
        "L3MON4D3/LuaSnip",
        -- For autocompletion
        "saadparwaiz1/cmp_luasnip",
        -- Useful snippets.
        "rafamadriz/friendly-snippets",
        -- Vs-code like pictograms.
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Load vs-code like snippets from plugins (e.g. friendly-snippets).
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Previous suggestion.
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                -- Next suggestion.
                ["<C-j>"] = cmp.mapping.select_next_item(),
                -- Show completion suggestions.
                ["<C-Space>"] = cmp.mapping.complete(),
                -- Close completion window.
                ["<C-e>"] = cmp.mapping.abort(),

                -- Scroll.
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Confirm by enter or tab.
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- Sources for autocompletion.
            sources = cmp.config.sources({
                -- Copilot.
                { name = "copilot" },
                -- Lsp.
                { name = "nvim_lsp" },
                -- Snippets.
                { name = "luasnip" },
                -- Text within current buffer.
                { name = "buffer" },
                -- File system paths.
                { name = "path" },
            }),
            -- Configure lspkind for vs-code like icons.
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                    symbol_map = {
                        Copilot = "",
                    },
                }),
            },
        })
    end,
}

-- local cmp_status, cmp = pcall(require, "cmp")
-- if not cmp_status then
--     return
-- end
--
-- local luasnip_status, luasnip = pcall(require, "luasnip")
-- if not luasnip_status then
--     return
-- end
--
-- local lspkind_status, lspkind = pcall(require, "lspkind")
-- if not lspkind_status then
--     return
-- end
--
-- require("luasnip/loaders/from_vscode").lazy_load()
--
-- vim.opt.completeopt = "menu,menuone,noselect"
--
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end,
--     },
--     mapping = cmp.mapping.preset.insert({
--         -- Previous suggestion.
--         ["<C-k>"] = cmp.mapping.select_prev_item(),
--         -- Next suggestion.
--         ["<C-j>"] = cmp.mapping.select_next_item(),
--         -- Show completion suggestions.
--         ["<C-Space>"] = cmp.mapping.complete(),
--         -- Close completion window.
--         ["<C-e>"] = cmp.mapping.abort(),
--
--         -- Scroll.
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--
--         -- Confirm by enter or tab.
--         ["<CR>"] = cmp.mapping.confirm({ select = false }),
--         ["<Tab>"] = cmp.mapping.confirm({ select = false }),
--     }),
--     -- Sources for autocompletion.
--     sources = cmp.config.sources({
--         -- Copilot.
--         { name = "copilot" },
--         -- Lsp.
--         { name = "nvim_lsp" },
--         -- Snippets.
--         { name = "luasnip" },
--         -- Text within current buffer.
--         { name = "buffer" },
--         -- File system paths.
--         { name = "path" },
--     }),
--     -- Configure lspkind for vs-code like icons.
--     formatting = {
--         format = lspkind.cmp_format({
--             maxwidth = 50,
--             ellipsis_char = "...",
--             symbol_map = {
--                 Copilot = "",
--             },
--         }),
--     },
-- })
