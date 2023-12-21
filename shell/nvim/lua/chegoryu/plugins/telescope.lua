return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        -- Dependency for better sorting performance.
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- Better live grep.
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local live_grep_args = require("telescope-live-grep-args.actions")

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
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-i>"] = live_grep_args.quote_prompt({
                                postfix = " --iglob **/",
                            }),
                        },
                    },
                },
            },
        })

        telescope.load_extension("find_template")
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        -- Set keymaps.
        local keymap = vim.keymap

        -- General.

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
            desc = "Fuzzy find files in current working directory.",
        })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep_args<CR>", {
            desc = "Find string in current working directory as you type.",
        })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", {
            desc = "Find string under cursor in current working directory.",
        })
        keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", {
            desc = "Open last telescope window.",
        })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {
            desc = "Ppen buffers in current neovim instance.",
        })
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {
            desc = "List available help tags.",
        })
        keymap.set("n", "<leader>ft", "<cmd>Telescope find_template type=insert<CR>", {
            desc = "Find template. (from template.nvim plugin).",
        })

        -- Git commands.

        -- List all git commits (use <CR> to checkout) ["gc" for git commits].
        keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", {
            desc = 'List all git commits (use <CR> to checkout) ["gc" for git commits].',
        })
        -- List git commits for current file/buffer (use <CR> to checkout) ["gfc" for git file commits].
        keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>", {
            desc = 'List git commits for current file/buffer (use <CR> to checkout) ["gfc" for git file commits].',
        })
        -- List git branches (use <CR> to checkout) ["gb" for git branch].
        keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", {
            desc = 'List git branches (use <CR> to checkout) ["gb" for git branch].',
        })
        -- List current changes per file with diff preview ["gs" for git status].
        keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", {
            desc = 'List current changes per file with diff preview ["gs" for git status].',
        })
    end,
}
