return {
  'Saghen/blink.cmp',
  event = { 'VimEnter' },
  version = '1.*',
  dependencies = {
    'kristijanhusak/vim-dadbod-completion',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      dependencies = {
        'rafamadriz/friendly-snippets',
        'folke/lazydev.nvim',
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip').filetype_extend('dart', { 'flutter' })
        require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })
      end,
    },
    'nvim-mini/mini.icons',
  },
  opts = {
    keymap = {
      preset = 'enter',
    },
    snippets = {
      preset = 'luasnip',
    },
    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
        sql = { 'dadbod' },
      },
      providers = {
        dadbod = {
          module = 'vim_dadbod_completion.blink',
        },
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        path = {
          opts = {
            show_hidden_files_by_default = true,
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },
    completion = {
      keyword = {
        range = 'full',
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        border = 'rounded',
        draw = {
          -- treesitter = { 'lsp' },
          align_to = 'cursor',
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            source_name = {
              text = function(ctx) return '[' .. ctx.source_name .. ']' end,
            },
          },

          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    -- appearance = {
    --   kind_icons = require('icons').symbol_kinds,
    -- },
  },
}
