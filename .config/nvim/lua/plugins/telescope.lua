return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function()
      local telescope = require('telescope')

      local default_style = {
        theme = 'dropdown',
        winblend = 10,
      }

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = function(...)
                return require('telescope.actions').preview_scrolling_up(...)
              end,
              ['<C-d>'] = function(...)
                return require('telescope.actions').preview_scrolling_down(...)
              end,
              ['<C-j>'] = function(...)
                return require('telescope.actions').move_selection_next(...)
              end,
              ['<C-k>'] = function(...)
                return require('telescope.actions').move_selection_previous(...)
              end,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(default_style),
          },
          fzf = {},
        },
        pickers = {
          find_files = default_style,
          oldfiles = default_style,
          grep_string = default_style,
          live_grep = default_style,
          lsp_references = default_style,
          current_buffer_fuzzy_find = vim.tbl_extend(
            'error',
            default_style,
            { previewer = false }
          ),
        },
      }
      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')
    end,
    keys = {
      {
        '<leader><Space>',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>so',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = '[S]earch [O]ld files',
      },
      {
        '<leader>sf',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find()
        end,
        desc = 'Fuzzy find in current buffer',
      },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>sg',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = '[S]earch by [G]rep',
      },
    },
  },
}
