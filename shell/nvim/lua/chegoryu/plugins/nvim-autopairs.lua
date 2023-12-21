return {
    -- Autoclose parens, brackets, quotes, etc...
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            -- Enable treesitter.
            check_ts = true,
            ts_config = {
                -- Don't add pairs in lua string treesitter nodes.
                lua = { "string" },
                -- Don't add pairs in javscript template_string treesitter nodes.
                javascript = { "template_string" },
                -- Don't check treesitter on java.
                java = false,
            },
        })

        -- Setup nvim-autopairs completion functionality.
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        -- Make autopairs and completion work together.
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
