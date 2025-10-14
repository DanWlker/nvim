return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then return end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').filetype_extend('dart', { 'flutter' })
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    luasnip.config.setup({})

    local cmp_kinds = {
      Text = '󰉿 ',
      Method = '󰊕 ',
      Function = '󰊕 ',
      Constructor = '󰒓 ',
      Field = '󰜢 ',
      Variable = '󰆦 ',
      Property = '󰖷 ',
      Class = '󱡠 ',
      Interface = '󱡠 ',
      Struct = '󱡠 ',
      Module = '󰅩 ',
      Unit = '󰪚 ',
      Value = '󰦨 ',
      Enum = '󰦨 ',
      EnumMember = '󰦨 ',
      Keyword = '󰻾 ',
      Constant = '󰏿 ',
      Snippet = '󱄽 ',
      Color = '󰏘 ',
      File = '󰈔 ',
      Reference = '󰬲 ',
      Folder = '󰉋 ',
      Event = '󱐋 ',
      Operator = '󰪚 ',
      TypeParameter = '󰬛 ',
    }

    vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
      contents = vim.lsp.util._normalize_markdown(contents, {
        width = vim.lsp.util._make_floating_popup_size(contents, opts),
      })

      vim.bo[bufnr].filetype = 'markdown'
      vim.treesitter.start(bufnr)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

      return contents
    end

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete({}),
      }),
      sources = {
        {
          name = 'lazydev',
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
      },

      window = {
        completion = cmp.config.window.bordered({
          winhighlight = 'Normal:Normal,FloatBorder:BlinkCmpMenuBorder,CursorLine:Visual,Search:None',
        }),
        documentation = cmp.config.window.bordered(),
      },
      -- view = {
      --   docs = {
      --     auto_open = false,
      --   },
      -- },
      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(_, item)
          item.kind = cmp_kinds[item.kind] or ''
          return item
        end,
      },
      -- formatting = {
      --   format = function(_, item)
      --     item.kind = (cmp_kinds[item.kind] or '') .. (item.kind or '')
      --
      --     local widths = {
      --       abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
      --       menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
      --     }
      --
      --     for key, width in pairs(widths) do
      --       if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
      --         item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. '…'
      --       end
      --     end
      --
      --     return item
      --   end,
      -- },
      -- formatting = {
      --   format = function(entry, vim_item)
      --     -- Kind icons
      --     vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. (vim_item.kind or '')
      --     -- Source
      --     vim_item.menu = ({
      --       buffer = '[Buffer]',
      --       nvim_lsp = '[LSP]',
      --       luasnip = '[LuaSnip]',
      --       nvim_lua = '[Lua]',
      --       latex_symbols = '[LaTeX]',
      --     })[entry.source.name]
      --     return vim_item
      --   end,
      -- },

      experimental = {
        ghost_text = true,
      },
      -- got this from here https://www.reddit.com/r/neovim/comments/1f1rxtx/comment/lk5dk9k
      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true,
      },
    })
  end,
}
