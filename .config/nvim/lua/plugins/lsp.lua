return {
  { -- LSP config
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.diagnostic.config {
        virtual_text = false,
        update_in_insert = false,
      }

      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set(
            'n',
            keys,
            func,
            { noremap = true, buffer = bufnr, desc = desc }
          )
        end

        map('<leader>ld', vim.lsp.buf.definition, '[D]efinition')
        map('<leader>lc', vim.lsp.buf.declaration, 'De[C]laration')
        map('<leader>li', vim.lsp.buf.implementation, '[I]mplementation')
        map('<leader>lt', vim.lsp.buf.type_definition, '[T]ype Definition')
        map(
          '<leader>ly',
          require('telescope.builtin').lsp_document_symbols,
          'Document S[Y]mbols'
        )
        map(
          '<leader>lr',
          require('telescope.builtin').lsp_references,
          '[R]eferences'
        )

        map('<leader>ln', vim.lsp.buf.rename, 'Re[n]ame')
        map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')

        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>lf', function()
          local have_nls = #require('null-ls.sources').get_available(
            vim.bo[bufnr].filetype,
            'NULL_LS_FORMATTING'
          ) > 0

          vim.lsp.buf.format {
            bufnr = bufnr,
            async = true,
            filter = function(client)
              if have_nls then
                return client.name == 'null-ls'
              end
              return client.name ~= 'null-ls'
            end,
          }
        end, 'Format')

        vim.keymap.set(
          'i',
          '<C-s>',
          vim.lsp.buf.signature_help,
          { desc = 'Signature help', noremap = true, buffer = bufnr }
        )
      end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      local servers = {
        -- clangd = {},
        -- pyright = {},
        -- rust_analyzer = {},
        gopls = {},
        tsserver = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Setup mason so it can manage external tooling
      require('mason').setup()

      -- Ensure the servers above are installed
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          --nls.builtins.formatting.eslint_d,
          --nls.builtins.formatting.prettierd,
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.eslint,
          nls.builtins.formatting.stylua,
          --nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      luasnip.config.setup {}

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-.>'] = cmp.mapping.complete {},
          ['<C-f>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Right>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        '<leader>xx',
        '<cmd>TroubleToggle<cr>',
        desc = 'Toggle (Trouble)',
      },
      {
        '<leader>xd',
        '<cmd>TroubleToggle document_diagnostics<cr>',
        desc = 'Document Diagnostics (Trouble)',
      },
      {
        '<leader>xw',
        '<cmd>TroubleToggle workspace_diagnostics<cr>',
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>TroubleToggle loclist<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xq',
        '<cmd>TroubleToggle quickfix<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
