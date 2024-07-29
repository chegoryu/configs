return {
    -- Whitespaces highlight.
    "lukoshkin/highlight-whitespace",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        tws = "[\r \t]\\+$",
        clear_on_bufleave = false,
        palette = {
            go = {
                tws = "RoyalBlue4",
            },
            other = {
                tws = "RoyalBlue4",
                ["\\t\\+"] = "MediumPurple4",
            },
        },
    },
}
