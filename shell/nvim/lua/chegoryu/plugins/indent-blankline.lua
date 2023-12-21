local setup, indentblankline = pcall(require, "ibl")
if not setup then
    return
end

local setup_hooks, hooks = pcall(require, "ibl.hooks")
if not setup_hooks then
    return
end

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#7FDBCA" })
end)

indentblankline.setup({
    scope = {
        char = "│",
        enabled = true,
        show_start = false,
        show_end = false,
    },
})
