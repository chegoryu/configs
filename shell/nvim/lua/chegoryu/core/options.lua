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

--------------------------------------------------------------------------------
-- Appearance.
--------------------------------------------------------------------------------

opt.list = true
opt.listchars:append({
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
-- Split windows.
--------------------------------------------------------------------------------

opt.splitright = true
opt.splitbelow = true

--------------------------------------------------------------------------------
-- Keywords.
--------------------------------------------------------------------------------

-- Consider string-string as whole word.
opt.iskeyword:append("-")