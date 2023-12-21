return {
    -- Git integration.
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            current_line_blame_opts = {
                delay = 0,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d, %H:%M> - <summary>",
        })

        -- Set keymaps.
        local keymap = vim.keymap

        keymap.set("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<CR>", {
            desc = "Toggle current line blame.",
        })
    end,
}
