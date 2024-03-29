return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        -- Keybinds for navigation in lspsaga window.
        scroll_preview = {
            scroll_down = "<C-f>",
            scroll_up = "<C-b>",
        },
        finder = {
            keys = {
                -- Use enter to open file with finder preview.
                toggle_or_open = {
                    "o",
                    "<CR>",
                },
            },
        },
        definition = {
            keys = {
                -- Use enter to open file with definition preview.
                edit = {
                    "<C-c>o",
                    "<CR>",
                },
            },
        },
        ui = {
            colors = {
                normal_bg = "#022746",
            },
        },
        symbol_in_winbar = {
            separator = "> ",
        },
    },
}
