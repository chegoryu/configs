local setup, indentblankline = pcall(require, "indent_blankline")
if not setup then
    return
end

indentblankline.setup({
    show_current_context = true,
    show_trailing_blankline_indent = false,
})
