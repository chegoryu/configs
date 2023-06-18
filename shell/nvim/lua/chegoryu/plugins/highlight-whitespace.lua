local setup, highlightwhitespace = pcall(require, "highlight-whitespace")
if not setup then
    return
end

highlightwhitespace.setup({
    tws = "[\r \t]\\+$",
    clear_on_winleave = false,
    user_palette = {
        other = {
            tws = "RoyalBlue4",
        },
    },
})
