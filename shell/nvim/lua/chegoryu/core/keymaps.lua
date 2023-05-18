-- Set leader key to space.
vim.g.mapleader = " "

local keymap = vim.keymap

--------------------------------------------------------------------------------
-- General.
--------------------------------------------------------------------------------

-- Use jk to exit insert mode.
keymap.set("i", "jk", "<ESC>")

-- Clear search highlights.
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Delete single character without copying into register.
keymap.set("n", "x", '"_x')

-- Increment/decrement numbers.
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- Window management.

-- Split window vertically.
keymap.set("n", "<leader>sv", "<C-w>v")
-- Split window horizontally.
keymap.set("n", "<leader>sh", "<C-w>s")
-- Make split windows equal width & height.
keymap.set("n", "<leader>se", "<C-w>=")
-- Close current split window.
keymap.set("n", "<leader>sx", ":close<CR>")

-- Open new tab.
keymap.set("n", "<leader>to", ":tabnew<CR>")
-- Close current tab.
keymap.set("n", "<leader>tx", ":tabclose<CR>")
-- Go to next tab.
keymap.set("n", "<leader>tn", ":tabn<CR>")
-- Go to previous tab.
keymap.set("n", "<leader>tp", ":tabp<CR>")

--------------------------------------------------------------------------------
-- Nim-maximizer.
--------------------------------------------------------------------------------

-- Toggle split window maximization.
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

--------------------------------------------------------------------------------
-- Nvim-tree.
--------------------------------------------------------------------------------

-- Toggle file explorer.
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

--------------------------------------------------------------------------------
-- Telescope.
--------------------------------------------------------------------------------

-- General.

-- Find files within current working directory, respects .gitignore.
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
-- Find string in current working directory as you type.
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep_args<CR>")
-- Find string under cursor in current working directory.
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
-- Fist open buffers in current neovim instance.
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
-- List available help tags.
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
-- Find template (from template.nvim plugin).
keymap.set("n", "<leader>ft", "<cmd>Telescope find_template type=insert<CR>")

-- Git commands.

-- List all git commits (use <CR> to checkout) ["gc" for git commits].
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
-- List git commits for current file/buffer (use <CR> to checkout) ["gfc" for git file commits].
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>")
-- List git branches (use <CR> to checkout) ["gb" for git branch].
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
-- List current changes per file with diff preview ["gs" for git status].
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")

--------------------------------------------------------------------------------
-- Lsp.
--------------------------------------------------------------------------------

-- Restart lsp server.
keymap.set("n", "<leader>rs", ":LspRestart<CR>")
