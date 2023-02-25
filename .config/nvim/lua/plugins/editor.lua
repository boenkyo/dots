return {
	{ -- Colorscheme
		'sainnhe/gruvbox-material',
		priority = 1000,
		config = function()
			vim.o.background = 'dark'
			vim.g.gruvbox_material_enable_bold = 'true'
			vim.g.gruvbox_material_enable_italic = 'true'
			vim.cmd.colorscheme('gruvbox-material')
		end,
	},

	{ -- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'gruvbox-material',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	{ -- Filetree
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ '<leader>e',
				function()
					require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "File [E]xplorer (cwd)"
			}
		},
		config = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			require("neo-tree").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = true,
		},
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
			{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				show_close_icon = false,
				show_buffer_close_icons = false,
				separator_style = 'thin',
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	{ -- Terminal
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {
			open_mapping = [[<C-\>]],
		},
	}

}
