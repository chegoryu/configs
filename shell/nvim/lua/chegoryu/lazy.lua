local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local imports = {
    { import = "chegoryu.plugins.common" },
    { import = "chegoryu.plugins.editor" },
    { import = "chegoryu.plugins.lsp" },
    { import = "chegoryu.plugins.ui" },
}

require("lazy").setup(imports, {
    install = {
        colorscheme = { "nightfly" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})
