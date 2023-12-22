return {
    -- Add, delete, change surroundings.
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    -- Use for stability; omit to use 'main' branch for the latest features.
    version = "*",
    opts = {},
}
