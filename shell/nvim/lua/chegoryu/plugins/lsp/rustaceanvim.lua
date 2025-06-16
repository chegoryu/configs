return {
    -- Configure rust LSP.
    "mrcjkb/rustaceanvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    lazy = false,
}
