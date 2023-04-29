local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                -- Move to prev result.
                ["<C-k>"] = actions.move_selection_previous,
                -- Move to next result.
                ["<C-j>"] = actions.move_selection_next,

                -- Send selected to quickfixlist.
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                -- Close with one ESC (even in insert mode).
                ["<ESC>"] = actions.close,
            },
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("find_template")
