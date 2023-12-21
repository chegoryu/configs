return {
    -- Blankline.
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ibl = require("ibl")
        local ibl_hooks = require("ibl.hooks")

        ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IblScope", { fg = "#7FDBCA" })
        end)

        ibl.setup({
            scope = {
                char = "│",
                enabled = true,
                show_start = false,
                show_end = false,
            },
        })
    end,
}
