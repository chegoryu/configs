return {
    -- Whitespaces auto trimming.
    "nvimdev/template.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local template = require("template")

        template.setup({
            temp_dir = "~/.templates",
        })
    end,
}
