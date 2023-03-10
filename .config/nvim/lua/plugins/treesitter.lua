return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<c-space>", desc = "Increment selection" },
		{ "<bs>",      desc = "Shrink selection",   mode = "x" },
	},
	---@type TSConfig
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			"bash",
			"go",
			"help",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = "<nop>",
				node_decremental = "<bs>",
			},
		},
	},
	---@param opts TSConfig
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
