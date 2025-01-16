-- return {
--   'saghen/blink.cmp',
--   -- optional: provides snippets for the snippet source
--   dependencies = 'rafamadriz/friendly-snippets',
--
--   -- use a release tag to download pre-built binaries
--   version = '*',
--   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--   -- build = 'cargo build --release',
--   -- If you use nix, you can build from source using latest nightly rust with:
--   -- build = 'nix run .#build-plugin',
--
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     -- 'default' for mappings similar to built-in completion
--     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
--     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
--     -- See the full "keymap" documentation for information on defining your own keymap.
--     keymap = { preset = 'default' },
--
--     appearance = {
--       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
--       -- Useful for when your theme doesn't support blink.cmp
--       -- Will be removed in a future release
--       use_nvim_cmp_as_default = true,
--       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--       -- Adjusts spacing to ensure icons are aligned
--       nerd_font_variant = 'mono',
--
--       -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
--       kind_icons = {
--         Copilot = '',
--         Text = '󰉿',
--         Method = '󰊕',
--         Function = '󰊕',
--         Constructor = '󰒓',
--
--         Field = '󰜢',
--         Variable = '󰆦',
--         Property = '󰖷',
--
--         Class = '󱡠',
--         Interface = '󱡠',
--         Struct = '󱡠',
--         Module = '󰅩',
--
--         Unit = '󰪚',
--         Value = '󰦨',
--         Enum = '󰦨',
--         EnumMember = '󰦨',
--
--         Keyword = '󰻾',
--         Constant = '󰏿',
--
--         Snippet = '󱄽',
--         Color = '󰏘',
--         File = '󰈔',
--         Reference = '󰬲',
--         Folder = '󰉋',
--         Event = '󱐋',
--         Operator = '󰪚',
--         TypeParameter = '󰬛',
--       },
--     },
--
--     -- Default list of enabled providers defined so that you can extend it
--     -- elsewhere in your config, without redefining it, due to `opts_extend`
--     sources = {
--       default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'dadbod' },
--       providers = {
--         copilot = {
--           name = 'copilot',
--           module = 'blink-cmp-copilot',
--           score_offset = 100,
--           async = true,
--           transform_items = function(_, items)
--             local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
--             local kind_idx = #CompletionItemKind + 1
--             CompletionItemKind[kind_idx] = 'Copilot'
--             for _, item in ipairs(items) do
--               item.kind = kind_idx
--             end
--             return items
--           end,
--         },
--         dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
--       },
--     },
--
--     signature = {
--       enabled = true,
--     },
--
--     completion = {
--       menu = {
--         border = 'rounded',
--
--         -- nvim-cmp style menu
--         draw = {
--           columns = {
--             { 'label', 'label_description', gap = 1 },
--             { 'kind_icon', 'kind' },
--           },
--         },
--
--         -- Show documentation when selecting a completion item
--         -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
--
--         -- Display a preview of the selected item on the current line
--         -- ghost_text = { enabled = true },
--       },
--     },
--   },
--   opts_extend = { 'sources.default' },
-- }

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = 'default' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      -- use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      menu = {
        -- border = 'rounded',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'rounded',
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'dadbod' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = 'Copilot'
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
