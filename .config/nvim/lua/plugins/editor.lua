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
        theme = 'gruvbox-material',
      },
    },
  },

  { -- Filetree
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute {
            toggle = true,
            dir = vim.loop.cwd(),
          }
        end,
        desc = 'File [E]xplorer (cwd)',
      },
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      require('neo-tree').setup {
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            never_show = {
              '.DS_Store',
            },
            hide_by_name = {
              '.git',
            },
            hide_dotfiles = false,
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = 'A',
              modified = 'M',
              deleted = 'D',
              renamed = 'R',
              untracked = 'U',
              ignored = 'I',
              unstaged = '',
              staged = 'S',
              conflict = 'C',
            },
          },
        },
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
      filetype_exclude = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
      },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>bp',
        '<cmd>BufferLineTogglePin<CR>',
        desc = 'Toggle pin',
      },
      {
        '<leader>bP',
        '<cmd>BufferLineGroupClose ungrouped<CR>',
        desc = 'Delete non-pinned buffers',
      },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = 'thin',
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },

  { -- Terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-;>]],
      on_open = function(t)
        vim.api.nvim_buf_set_keymap(
          t.bufnr,
          't',
          '<esc>',
          [[<C-\><C-n>]],
          { noremap = true }
        )
      end,
    },
  },
}
