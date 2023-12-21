return {
    -- Whitespaces highlight.
    "lukoshkin/highlight-whitespace",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local highlightwhitespace = require("highlight-whitespace")

        highlightwhitespace.setup({
            tws = "[\r \t]\\+$",
            clear_on_winleave = false,
            palette = {
                go = {
                    tws = "RoyalBlue4",
                },
                other = {
                    tws = "RoyalBlue4",
                    ["\\t\\+"] = "MediumPurple4",
                },
            },
        })
    end,
}
