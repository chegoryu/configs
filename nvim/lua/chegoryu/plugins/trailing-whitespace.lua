local setup, trailingwhitespace = pcall(require, "trailing-whitespace")
if not setup then
    return
end

trailingwhitespace.setup({
    patterns = {
        "[\r \t]\\+$",
    },
    default_color = "RoyalBlue4",
})
