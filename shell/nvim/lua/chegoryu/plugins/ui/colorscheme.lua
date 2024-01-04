return {
    -- Colorscheme.
    "bluz71/vim-nightfly-guicolors",
    -- Make sure to load this before all the other start plugins.
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme nightfly]])
    end,
}
