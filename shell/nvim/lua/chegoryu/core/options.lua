local opt = vim.opt

--------------------------------------------------------------------------------
-- Tabline.
--------------------------------------------------------------------------------

opt.showtabline = 2

--------------------------------------------------------------------------------
-- Line numbers.
--------------------------------------------------------------------------------

opt.relativenumber = false
opt.number = true

--------------------------------------------------------------------------------
-- Tabs & indentation.
--------------------------------------------------------------------------------

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

--------------------------------------------------------------------------------
-- Line wrapping.
--------------------------------------------------------------------------------

opt.wrap = false

--------------------------------------------------------------------------------
-- Search settings.
--------------------------------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true
-- Remove "search hit BOTTOM, continuing at TOP" and "search hit TOP, continuing at BOTTOM" messages.
vim.opt.shortmess:append("s")

--------------------------------------------------------------------------------
-- Appearance.
--------------------------------------------------------------------------------

opt.list = true
opt.listchars:append({
    tab = "‣‣",
    trail = "·",
})
opt.cursorline = true

-- Turn on termguicolors for nightfly colorscheme to work.
opt.termguicolors = true
-- Colorschemes that can be light or dark will be made dark.
opt.background = "dark"
-- Show sign column so that text doesn't shift.
opt.signcolumn = "yes"

--------------------------------------------------------------------------------
-- Backspace.
--------------------------------------------------------------------------------

-- Allow backspace on indent, end of line or insert mode start position.
opt.backspace = "indent,eol,start"

--------------------------------------------------------------------------------
-- Clipboard.
--------------------------------------------------------------------------------

-- Use system clipboard as default register.
opt.clipboard:append("unnamedplus")

--------------------------------------------------------------------------------
-- Windows splitting.
--------------------------------------------------------------------------------

opt.splitright = true
opt.splitbelow = true

--------------------------------------------------------------------------------
-- Keywords.
--------------------------------------------------------------------------------

-- Consider string-string as whole word.
opt.iskeyword:append("-")
