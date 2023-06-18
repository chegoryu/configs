local setup, highlightwhitespace = pcall(require, "highlight-whitespace")
if not setup then
    return
end

highlightwhitespace.setup({
    tws = "[\r \t]\\+$",
    clear_on_winleave = false,
    user_palette = {
        go = {
            tws = "RoyalBlue4",
        },
        other = {
            tws = "RoyalBlue4",
            ["\\t\\+"] = "MediumPurple4",
        },
    },
})
