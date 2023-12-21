-- Set leader key to space.
vim.g.mapleader = " "

local keymap = vim.keymap

--------------------------------------------------------------------------------
-- General.
--------------------------------------------------------------------------------

keymap.set("i", "jk", "<ESC>", {
    desc = "Exit insert mode.",
})
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", {
    desc = "Clear search highlights.",
})

keymap.set("n", "x", '"_x', {
    desc = "Delete single character without copying into register.",
})

-- Increment/decrement numbers.
keymap.set("n", "<leader>+", "<C-a>", {
    desc = "Increment number under cursor.",
})
keymap.set("n", "<leader>-", "<C-x>", {
    desc = "Decrement number under cursor.",
})

-- Window management.

keymap.set("n", "<leader>sv", "<C-w>v", {
    desc = "Split window vertically.",
})
keymap.set("n", "<leader>sh", "<C-w>s", {
    desc = "Split window horizontally.",
})
keymap.set("n", "<leader>se", "<C-w>=", {
    desc = "Make split windows equal width & height.",
})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {
    desc = "Close current split window.",
})

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {
    desc = "Open new tab.",
})
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {
    desc = "Close current tab.",
})
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {
    desc = "Go to next tab.",
})
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {
    desc = "Go to previous tab.",
})
