local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if not lspsaga_status then
    return
end

lspsaga.setup({
    -- Keybinds for navigation in lspsaga window.
    scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
    -- Use enter to open file with definition preview.
    definition = {
        edit = "<CR>",
    },
    ui = {
        colors = {
            normal_bg = "#022746",
        },
    },
    symbol_in_winbar = {
        separator = "> ",
    },
})
