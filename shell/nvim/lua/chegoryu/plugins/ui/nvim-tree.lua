return {
    -- File explorer.
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require("nvim-tree")

        -- Recommended settings from nvim-tree documentation.
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Change color for arrows in tree to light blue.
        vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

        nvimtree.setup({
            view = {
                width = 35,
            },
            -- Change folder arrow icons.
            renderer = {
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                        },
                    },
                },
            },
            -- Disable window_picker for explorer to work well with window splits.
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
        })

        -- Set keymaps.
        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {
            desc = "Toggle file explorer",
        })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", {
            desc = "Go to current file in file explorer.",
        })
        keymap.set("n", "<leader>eft", "<cmd>NvimTreeFindFileToggle<CR>", {
            desc = "Toggle file explorer on current file.",
        })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {
            desc = "Collapse file explorer.",
        })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {
            desc = "Refresh file explorer.",
        })
    end,
}
