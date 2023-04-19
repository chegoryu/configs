local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	-- Enable syntax highlighting.
	highlight = {
		enable = true,
	},
	-- Enable indentation.
	indent = {
		enable = true,
	},
	-- Enable autotagging.
	autotag = {
		enable = true,
	},
	-- Ensure these language parsers are installed.
	ensure_installed = {
		"c",
		"cpp",

		"python",

		"go",
		"gosum",
		"gomod",

		"rust",

		"lua",

		"java",
		"kotlin",

		"proto",

		"bash",

		"json",
		"yaml",

		"markdown",
		"markdown_inline",

		"vim",
		"dockerfile",
		"gitignore",
	},
	-- Auto install above language parsers.
	auto_install = true,
})
