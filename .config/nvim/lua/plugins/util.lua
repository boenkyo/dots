return {
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  'tpope/vim-sleuth',

  { -- Leap
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat'
    },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
    },
    opts = {},
  },

  { 'windwp/nvim-autopairs', opts = {} },

  {
    'Shatur/neovim-session-manager',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    opts = {},
    keys = {
      {
        '<leader>zl',
        '<cmd>SessionManager load_session<cr>',
        desc = 'Select and load session',
      },
      {
        '<leader>zd',
        '<cmd>SessionManager delete_session<cr>',
        desc = 'Select and delete session',
      },
    },
  },
}
