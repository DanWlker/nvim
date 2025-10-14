local file_ignore_patterns = { 'node_modules', '\\.git/', '\\.github/' }

-- Everything in here is from LazyVim
return {
  'ibhagwan/fzf-lua',
  -- init = function()
  --   ---@diagnostic disable-next-line: duplicate-set-field
  --   vim.ui.select = function(...)
  --     require 'fzf-lua'
  --     return vim.ui.select(...)
  --   end
  -- end,
  keys = {
    {
      '<leader>fh',
      function() require('fzf-lua').helptags() end,
      desc = 'Find Help',
    },
    {
      '<leader>fk',
      function() require('fzf-lua').keymaps() end,
      desc = 'Find Keymaps',
    },
    {
      '<leader>ff',
      function() require('fzf-lua').files() end,
      desc = 'Find Files',
    },
    {
      '<leader>fm',
      function() require('fzf-lua').builtin() end,
      desc = 'Find More Uses',
    },
    {
      '<leader>fw',
      function() require('fzf-lua').grep_visual() end,
      mode = 'x',
      desc = 'Find Word',
    },
    {
      '<leader>fw',
      function() require('fzf-lua').grep_cword() end,
      desc = 'Find Word',
    },
    {
      '<leader>fc',
      function() require('fzf-lua').commands() end,
      desc = 'Find Commands',
    },
    {
      '<leader>fC',
      function() require('fzf-lua').colorschemes() end,
      desc = 'Find Colorschemes',
    },
    {
      '<leader>fg',
      function() require('fzf-lua').live_grep() end,
      desc = 'Find with Grep',
    },
    {
      '<leader>fd',
      function() require('fzf-lua').diagnostics_workspace() end,
      desc = 'Find Diagnostics',
    },
    {
      '<leader>fa',
      function() require('fzf-lua').resume() end,
      desc = 'Find Again',
    },
    {
      '<leader>f.',
      function() require('fzf-lua').oldfiles({ cwd_only = true, stat_file = true }) end,
      desc = 'Find Recent Files',
    },
    {
      '<leader><leader>',
      function() require('fzf-lua').buffers() end,
      desc = 'Find Existing Buffers',
    },
    {
      '<leader>f/',
      function() require('fzf-lua').blines() end,
      mode = { 'n', 'x' },
      desc = 'Find Fuzzily in Current Buffer',
    },
    {
      '<leader>fo',
      function() require('fzf-lua').lines() end,
      desc = 'Find in Open Files',
    },
    {
      '<leader>fN',
      function() require('fzf-lua').files({ cwd = vim.fn.stdpath('config') }) end,
      desc = 'Find Neovim Files',
    },
    {
      '<leader>ft',
      function()
        require('todo-comments.fzf').todo({
          prompt = ' TODO   ',
        })
      end,
      desc = 'Find Todos',
    },
  },
  config = function()
    local fzf = require('fzf-lua') -- https://github.com/LazyVim/LazyVim/pull/5319
    local config = fzf.config
    -- local actions = fzf.actions

    -- Trouble
    config.defaults.actions.files['ctrl-t'] =
      require('trouble.sources.fzf').actions.open

    -- local img_previewer ---@type string[]?
    -- for _, v in ipairs {
    --   { cmd = 'ueberzug', args = {} },
    --   { cmd = 'chafa', args = { '{file}', '--format=symbols' } },
    --   { cmd = 'viu', args = { '-b' } },
    -- } do
    --   if vim.fn.executable(v.cmd) == 1 then
    --     img_previewer = vim.list_extend({ v.cmd }, v.args)
    --     break
    --   end
    -- end

    require('fzf-lua').setup({
      { 'hide', 'default-title' },
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
        ['--info'] = 'default',
        ['--layout'] = 'reverse-list',
        ['--tiebreak'] = 'begin',
      },
      defaults = {
        formatter = 'path.filename_first',
      },
      keymap = {
        builtin = {
          ['<M-a>'] = 'toggle-fullscreen',
          ['<C-f>'] = 'preview-page-down',
          ['<C-b>'] = 'preview-page-up',
          ['<M-p>'] = 'toggle-preview',
        },
        fzf = {
          ['ctrl-u'] = 'half-page-up',
          ['ctrl-d'] = 'half-page-down',
          ['ctrl-q'] = 'select-all+accept',
          ['ctrl-a'] = 'toggle-all',
        },
      },
      winopts = {
        -- width = 0.8,
        width = 0.8,
        -- height = 0.8,
        height = 0.65,
        -- row = 0.5,
        -- col = 0.5,
        -- backdrop = false,
        preview = {
          scrollbar = false,
          delay = 10,
          -- scrollchars = { '┃', '' },
          wrap = true,
          -- layout = 'vertical',
          -- vertical = 'up:40%',
          horizontal = 'right:50%',
          flip_columns = 140,
        },
      },
      files = {
        cwd_prompt = false,
        git_icons = false,
        hidden = true,
        no_ignore = true,
        follow = true,
        winopts = {
          preview = { hidden = true },
        },
        file_ignore_patterns = file_ignore_patterns,
      },
      grep = {
        header_prefix = ' ',
        hidden = true,
        no_ignore = true,
        follow = true,
        file_ignore_patterns = file_ignore_patterns,
        actions = {
          ['alt-s'] = {
            fn = function(_, opts)
              fzf.actions.toggle_flag(
                _,
                vim.tbl_extend('force', opts, {
                  toggle_flag = '--smart-case',
                })
              )
            end,
            desc = 'toggle-smart-case',
            header = function(o)
              local flag = '--smart-case'
              if not o.cmd then return 'Disable smart case' end

              if not o.cmd or not o.cmd:match(fzf.utils.lua_regex_escape(flag)) then
                return 'Enable smart case'
              else
                return 'Disable smart case'
              end
            end,
          },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s) return 'TroubleIcon' .. s end,
          symbol_fmt = function(s) return s:lower() .. '\t' end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
        },
      },
      -- from https://www.reddit.com/r/neovim/comments/1hhiidm/a_few_nice_fzflua_configurations_now_that_lazyvim/
      oldfiles = {
        include_current_session = true,
        winopts = {
          preview = { hidden = true },
        },
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
          -- extensions = {
          --   ['png'] = img_previewer,
          --   ['jpg'] = img_previewer,
          --   ['jpeg'] = img_previewer,
          --   ['gif'] = img_previewer,
          --   ['webp'] = img_previewer,
          -- },
          -- ueberzug_scaler = 'fit_contain',
        },
      },
    })
    require('fzf-lua').register_ui_select(function(fzf_opts, items)
      return vim.tbl_deep_extend('force', fzf_opts, {
        prompt = '   ',
        winopts = {
          title = ' ' .. vim.trim(
            (fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')
          ) .. ' ',
          title_pos = 'center',
        },
      }, fzf_opts.kind == 'codeaction' and {
        winopts = {
          backdrop = false,
          layout = 'vertical',
          -- Dynamic height
          -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 4) + 0.5),
          width = 0.3,
          row = 1,
          col = -2,
          --
          -- Static height
          -- height = 20,
          -- width = 70,
          relative = 'cursor',
          preview = {
            hidden = true, -- remove this if you would like to show preview
            layout = 'vertical',
            vertical = 'down:15,border-top',
          },
        },
      } or {
        winopts = {
          width = 0.5,
          -- height is number of items, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
        },
      })
    end)

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

        map(
          'grr',
          function()
            require('fzf-lua').lsp_references({
              sync = true,
              jump1 = true,
              jump1_action = require('fzf-lua.actions').file_switch_or_edit,
            })
          end,
          'Goto References'
        )
        map(
          'gri',
          function()
            require('fzf-lua').lsp_implementations({
              sync = true,
              jump1 = true,
              jump1_action = require('fzf-lua.actions').file_switch_or_edit,
            })
          end,
          'Goto Implementation'
        )
        map('gO', require('fzf-lua').lsp_document_symbols, 'Show Document Symbols')
        map(
          'grc',
          function() require('fzf-lua').lsp_incoming_calls() end,
          'Goto incoming calls'
        )
        map(
          'gro',
          function() require('fzf-lua').lsp_outgoing_calls() end,
          'Goto outgoing calls'
        )
        map(
          'gd',
          function()
            require('fzf-lua').lsp_definitions({
              sync = true,
              jump1 = true,
              jump1_action = require('fzf-lua.actions').file_switch_or_edit,
            })
          end,
          'Goto Definition'
        )
        map(
          'grt',
          function()
            require('fzf-lua').lsp_typedefs({
              sync = true,
              jump1 = true,
              jump1_action = require('fzf-lua.actions').file_switch_or_edit,
            })
          end,
          'Show Type Definition'
        )
        map(
          'gW',
          require('fzf-lua').lsp_live_workspace_symbols,
          'Show Workspace Symbols'
        )
      end,
    })
  end,
}
