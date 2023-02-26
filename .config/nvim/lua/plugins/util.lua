return {
	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',  opts = {} },

	{ 'nmac427/guess-indent.nvim', opts = {} },

	{ -- Leap
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end,
	},

	{ 'windwp/nvim-autopairs', opts = {} },

	{ -- Session manager
		'rmagatti/auto-session',
		dependencies = {
			{
				'rmagatti/session-lens',
				keys = {
					{ '<leader>ss', '<cmd>SearchSession<cr>', desc = "[S]earch [S]ession" },
				}
			}
		},
		opts = {}
	}
}
