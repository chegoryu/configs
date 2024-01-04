return {
    -- Whitespaces auto trimming.
    "nvimdev/template.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        temp_dir = "~/.templates",
    },
}
