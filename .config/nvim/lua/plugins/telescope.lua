return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = function(...) return require('telescope.actions').preview_scrolling_up(...) end,
						['<C-d>'] = function(...) return require('telescope.actions').preview_scrolling_down(...) end,
						['<C-j>'] = function(...) return require('telescope.actions').move_selection_next(...) end,
						['<C-k>'] = function(...) return require('telescope.actions').move_selection_previous(...) end,
					},
				},
			},
		},
		keys = {
			{ '<leader>sf', function() require('telescope.builtin').find_files() end, desc = "[S]earch [F]iles" },
			{ '<leader>so', function() require('telescope.builtin').oldfiles() end,   desc = "[S]earch [O]ld files" },
			{ '<leader>/', function()
				require('telescope.builtin').current_buffer_fuzzy_find(
					require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					})
			end,
				desc = "Fuzzy find in current buffer" },
			{ '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = "[S]earch current [W]ord" },
			{ '<leader>sg', function() require('telescope.builtin').live_grep() end,   desc = '[S]earch by [G]rep' },
		},
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable('make') == 1
		end,
		config = function()
			pcall(require('telescope').load_extension, 'fzf')
		end
	},
}
