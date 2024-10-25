local source_mapping = {
  nvim_lsp = '[LSP]',
  nvim_lua = '[LUA]',
  luasnip = '[SNIP]',
  buffer = '[BUF]',
  path = '[PATH]',
  treesitter = '[TREE]',
  ['vim-dadbod-completion'] = '[DB]',
  dap = '[DAP]',
}

local cmp_kinds = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

return {
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      color_square_width = 2,
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'
      local cmp_tailwind = require 'tailwindcss-colorizer-cmp'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect,preview' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm { select = true },
            c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'luasnip', group_index = 2 },
          { name = 'buffer', group_index = 2 },
          { name = 'treesitter', group_index = 2 },
          { name = 'path' },
        },
        performance = {
          debounce = 0,
          throttle = 0,
          fetching_timeout = 200,
          confirm_resolve_timeout = 1,
          async_budget = 1,
          max_view_entries = 100,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = {
            name = 'custom',
            selection_order = 'near_cursor',
            follow_cursor = true,
          },
        }, ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            symbol_map = { Copilot = '' },
            ellipsis_char = '...',
            before = function(entry, vim_item)
              cmp_tailwind.formatter(entry, vim_item)
              return vim_item
            end,
            menu = source_mapping,
          },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require('copilot_cmp.comparators').prioritize,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        }, -- formatting = {
        --   fields = { 'kind', 'abbr', 'menu' },
        --   format = function(entry, item)
        --     -- vscode like icons for cmp autocompletion
        --     local kind_fmt = lspkind.cmp_format {
        --       -- with_text = false, -- hide kind beside the icon
        --       mode = 'symbol_text',
        --       maxwidth = 50,
        --       ellipsis_char = '...',
        --       before = tailwindcss_colorizer_cmp.formatter, -- prepend tailwindcss-colorizer
        --     }(entry, item)
        --
        --     -- customize lspkind format
        --     local strings = vim.split(kind_fmt.kind, '%s', { trimempty = true })
        --
        --     if true then
        --       kind_fmt.kind = ' ' .. (strings[1] or '') .. ' ' -- default icons
        --     else
        --       kind_fmt.kind = '  ' .. (cmp_kinds[strings[2]] or '') .. ' ' -- vscode like icons
        --     end
        --
        --     kind_fmt.menu = strings[2] ~= nil and (' ' .. (strings[2] or '')) or ''
        --
        --     return kind_fmt
        --   end,
        -- },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
