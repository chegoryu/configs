local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
    return
end

gitsigns.setup({
    current_line_blame_opts = {
        delay = 0,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d, %H:%M> - <summary>",
})
