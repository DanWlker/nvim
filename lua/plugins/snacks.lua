local function list_extend(where, what)
  return vim.list_extend(vim.deepcopy(where), what)
end

local function list_filter(where, what)
  return vim
    .iter(where)
    :filter(function(val) return not vim.list_contains(what, val) end)
    :totable()
end

return {
  'DanWlker/snacks.nvim',
  branch = 'flatten_lsp_symbols',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  dependencies = {
    { 'nvim-mini/mini.icons', version = false },
    'folke/todo-comments.nvim',
    'folke/trouble.nvim',
  },
  keys = {
    -- {
    --   '\\',
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = 'Explorer Snacks (cwd)',
    -- },
    {
      '<leader>fn',
      function() Snacks.picker.notifications() end,
      desc = 'Find Notification History',
    },
    {
      '<leader>fh',
      function() Snacks.picker.help() end,
      mode = 'n',
      desc = 'Find Help',
    },
    {
      '<leader>fk',
      function() Snacks.picker.keymaps() end,
      mode = 'n',
      desc = 'Find Keymaps',
    },
    {
      '<leader>ff',
      function()
        local truncate_width = vim.api.nvim_win_get_width(0) * 0.8
        Snacks.picker.files({
          formatters = {
            file = {
              truncate = truncate_width,
            },
          },
        })
      end,
      mode = 'n',
      desc = 'Find Files',
    },
    {
      '<leader>fm',
      function() Snacks.picker.pickers() end,
      mode = 'n',
      desc = 'Find More Picker Uses',
    },
    {
      '<leader>fw',
      function() Snacks.picker.grep_word() end,
      mode = { 'n', 'x' },
      desc = 'Find Word',
    },
    {
      '<leader>fc',
      function() Snacks.picker.commands() end,
      mode = 'n',
      desc = 'Find Commands',
    },
    {
      '<leader>fg',
      function() Snacks.picker.grep() end,
      mode = 'n',
      desc = 'Find with Grep',
    },
    {
      '<leader>fd',
      function() Snacks.picker.diagnostics() end,
      mode = 'n',
      desc = 'Find Diagnostics',
    },
    {
      '<leader>fa',
      function() Snacks.picker.resume() end,
      mode = 'n',
      desc = 'Find Again',
    },
    {
      '<leader>f.',
      function() Snacks.picker.recent() end,
      mode = 'n',
      desc = 'Find Recent Files',
    },
    {
      '<leader><leader>',
      function() Snacks.picker.buffers() end,
      mode = 'n',
      desc = 'Find Existing Buffers',
    },
    {
      '<leader>f/',
      function() Snacks.picker.lines() end,
      desc = 'Find Fuzzily in Current Buffer',
    },
    {
      '<leader>fo',
      function() Snacks.picker.grep_buffers() end,
      desc = 'Find in Open Files',
    },
    {
      '<leader>fN',
      function()
        local truncate_width = vim.api.nvim_win_get_width(0) * 0.8
        Snacks.picker.files({
          cwd = vim.fn.stdpath('config'),
          formatters = {
            file = {
              truncate = truncate_width,
            },
          },
        })
      end,
      desc = 'Find Neovim Files',
    },
    {
      '<leader>f:',
      function() Snacks.picker.command_history() end,
      desc = 'Find Command History',
    },
    {
      '<leader>fj',
      function() Snacks.picker.jumps() end,
      desc = 'Find Jumps',
    },
    {
      '<leader>fu',
      function() Snacks.picker.undo() end,
      desc = 'Find Undo History',
    },
    {
      '<leader>fC',
      function() Snacks.picker.colorschemes() end,
      desc = 'Find Colorschemes',
    },
    {
      '<leader>fH',
      function() Snacks.picker.highlights() end,
      desc = 'Find Highlights',
    },
    {
      '<leader>f"',
      function() Snacks.picker.registers() end,
      desc = 'Find Registers',
    },
    {
      '<leader>ft',
      function() Snacks.picker.todo_comments() end,
      desc = 'Find Todo',
    },
    {
      '<leader>fT',
      function()
        Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
      end,
      desc = 'Find Todo/Fix/Fixme',
    },
  },
  config = function()
    local files_config = {
      hidden = true,
      ignored = true,
      exclude = { -- keep this ignored even if toggling to show hidden/ignored
        'node_modules',
        '.DS_Store',
        '*.docx',
        '*.zip',
        '*.pptx',
        '*.svg',
      },
      matcher = { frecency = true },
      layout = {
        hidden = { 'preview' },
      },
    }

    require('snacks').setup({
      styles = {
        input = {
          relative = 'cursor',
          row = -3,
          col = 0,
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      statuscolumn = {
        right = { 'fold' },
      },
      -- disable backdrop
      -- win = {
      --   backdrop = false,
      -- },
      --
      -- Not as good as hlchunk
      -- indent = {
      --   indent = {
      --     enabled = false,
      --   },
      --   animate = {
      --     enabled = false,
      --   },
      --   chunk = {
      --     enabled = true,
      --     char = {
      --       horizontal = '─',
      --       vertical = '│',
      --       corner_top = '╭',
      --       corner_bottom = '╰',
      --       arrow = '─',
      --     },
      --   },
      -- },
      picker = {
        actions = require('trouble.sources.snacks').actions,
        win = {
          input = {
            keys = {
              ['<c-t>'] = {
                'trouble_open',
                mode = { 'n', 'i' },
              },
            },
          },
        },
        sources = {
          smart = files_config,
          files = files_config,
          grep = {
            hidden = true,
            ignored = true,
            case_sens = false,
            toggles = {
              case_sens = 's',
            },
            finder = function(opts, ctx)
              local args_extend = { '--case-sensitive' }
              opts.args = list_filter(opts.args or {}, args_extend)
              if opts.case_sens then
                opts.args = list_extend(opts.args, args_extend)
              end
              return require('snacks.picker.source.grep').grep(opts, ctx)
            end,
            actions = {
              toggle_live_case_sens = function(picker) -- [[Override]]
                picker.opts.case_sens = not picker.opts.case_sens
                picker:find()
              end,
            },
            win = {
              input = {
                keys = {
                  ['<M-s>'] = { 'toggle_live_case_sens', mode = { 'i', 'n' } },
                },
              },
            },
          },
          commands = {
            layout = {
              preset = 'vscode',
            },
          },
          diagnostics = {
            layout = {
              preset = 'ivy_split',
            },
          },
          recent = {
            layout = {
              hidden = { 'preview' },
            },
          },
          buffer = {
            layout = {
              hidden = { 'preview' },
            },
          },
          colorschemes = {
            layout = {
              preset = 'ivy',
            },
          },
          notifications = {
            layout = {
              preset = 'vertical',
            },
          },
          registers = {
            layout = {
              preset = 'vertical',
            },
          },
        },
        -- kinds = require('icons').symbol_kinds,
        formatters = {
          file = {
            filename_first = true,
          },
        },
      },
      image = {},
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup(
        'danwlker/lsp-attach-pickers',
        { clear = true }
      ),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(
            mode,
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end

        local should_flatten = {
          ['json'] = true,
          ['yaml'] = true,
          ['toml'] = true,
          ['helm'] = true,
        }

        map('grr', function() Snacks.picker.lsp_references() end, 'Goto References')
        map(
          'gri',
          function() Snacks.picker.lsp_implementations() end,
          'Goto Implementation'
        )
        map('gO', function()
          local flatten, tree = false, true
          if should_flatten[vim.bo.ft] then
            flatten = true
            tree = false
          end

          Snacks.picker.lsp_symbols({
            filter = {
              default = true,
              lua = true,
            },
            tree = tree,
            flatten = flatten,
          })
        end, 'Show Document Symbols')
        -- map('grc', function()
        --   require('telescope.builtin').lsp_incoming_calls()
        -- end, 'Goto incoming calls')
        -- map('gro', function()
        --   require('telescope.builtin').lsp_outgoing_calls()
        -- end, 'Goto outgoing calls')
        map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
        map(
          'grt',
          function() Snacks.picker.lsp_type_definitions() end,
          'Show Type Definition'
        )
        map(
          'gW',
          function() Snacks.picker.lsp_workspace_symbols() end,
          'Open Workspace Symbols'
        )
      end,
    })
  end,
}
