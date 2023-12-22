local config = require("chegoryu.core.config")

return {
    config = config,
    api = vim.api,
    keymap = vim.keymap,
    opt = vim.bo,

    get_run_command = function(command)
        return ":15split<CR>:TmuxNavigateDown<CR>:term time " .. command .. "<CR>"
    end,
    filetype_options = vim.api.nvim_create_augroup("FiletypeOptions", {
        clear = true,
    }),
}
