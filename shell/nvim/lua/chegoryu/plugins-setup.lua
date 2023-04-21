-- Auto install packer if not installed.
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim and installs/updates/removes plugins when file is saved.
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

-- List of plugins to install.
return packer.startup(function(use)
    -- Packer can manage itself (magic).
    use("wbthomason/packer.nvim")

    --------------------------------------------------------------------------------
    -- General.
    --------------------------------------------------------------------------------

    -- Lua functions that many plugins use.
    use("nvim-lua/plenary.nvim")

    -- Ddd, delete, change surroundings.
    use("tpope/vim-surround")

    -- Replace with register contents using motion (gr + motion).
    use("inkarkat/vim-ReplaceWithRegister")

    -- Commenting with gc.
    use("numToStr/Comment.nvim")

    -- Autoclose parens, brackets, quotes, etc...
    use("windwp/nvim-autopairs")

    -- Git integration.
    use("lewis6991/gitsigns.nvim")

    -- Whitespaces.
    use("lukoshkin/trailing-whitespace")
    use("cappyzawa/trim.nvim")

    -- Templates.
    use("nvimdev/template.nvim")

    --------------------------------------------------------------------------------
    -- Appearance.
    --------------------------------------------------------------------------------

    -- Colorscheme.
    use("bluz71/vim-nightfly-guicolors")

    -- Vs-code like icons.
    use("nvim-tree/nvim-web-devicons")

    -- Statusline.
    use("nvim-lualine/lualine.nvim")

    -- Blankline.
    use("lukas-reineke/indent-blankline.nvim")

    -- Treesitter configuration (syntax highlighting).
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    --------------------------------------------------------------------------------
    -- Navigation.
    --------------------------------------------------------------------------------

    -- Tmux & split window navigation.
    use("christoomey/vim-tmux-navigator")

    -- Maximizes and restores current window.
    use("szw/vim-maximizer")

    -- File explorer.
    use("nvim-tree/nvim-tree.lua")

    --------------------------------------------------------------------------------
    -- Telescope.
    --------------------------------------------------------------------------------

    -- Dependency for better sorting performance.
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    -- Fuzzy finder.
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

    --------------------------------------------------------------------------------
    -- Autocompletion.
    --------------------------------------------------------------------------------

    -- Completion plugin.
    use("hrsh7th/nvim-cmp")
    -- Source for text in buffer.
    use("hrsh7th/cmp-buffer")
    -- Source for file system paths.
    use("hrsh7th/cmp-path")

    --------------------------------------------------------------------------------
    -- Snippets.
    --------------------------------------------------------------------------------

    -- Snippet engine.
    use("L3MON4D3/LuaSnip")
    -- For autocompletion.
    use("saadparwaiz1/cmp_luasnip")
    -- Useful snippets.
    use("rafamadriz/friendly-snippets")

    --------------------------------------------------------------------------------
    -- Lsp.
    --------------------------------------------------------------------------------

    -- Managing & installing lsp servers, linters & formatters.
    use("williamboman/mason.nvim")
    -- Bridges gap b/w mason & lspconfig.
    use("williamboman/mason-lspconfig.nvim")

    -- Configuring lsp servers.
    use("neovim/nvim-lspconfig")

    -- For autocompletion.
    use("hrsh7th/cmp-nvim-lsp")
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })

    -- Vs-code like icons for autocompletion.
    use("onsails/lspkind.nvim")

    --------------------------------------------------------------------------------
    -- Formatting & linting.
    --------------------------------------------------------------------------------

    -- Configure formatters & linters.
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    })

    -- Bridges gap b/w mason & null-ls.
    use("jayp0521/mason-null-ls.nvim")

    --------------------------------------------------------------------------------
    -- Bootstrap.
    --------------------------------------------------------------------------------

    if packer_bootstrap then
        require("packer").sync()
    end
end)
