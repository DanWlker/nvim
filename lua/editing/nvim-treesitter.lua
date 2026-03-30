return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    ---@return string?
    local function win_find_cl()
      local path = 'C:/Program Files (x86)/Microsoft Visual Studio'
      local pattern = '*/*/VC/Tools/MSVC/*/bin/Hostx64/x64/cl.exe'
      return vim.fn.globpath(path, pattern, true, true)[1]
    end

    ---@return boolean ok
    local function hasDependencies()
      local is_win = vim.fn.has('win32') == 1
      ---@param tool string
      ---@param win boolean?
      local function have(tool, win)
        return (win == nil or is_win == win) and vim.fn.executable(tool) == 1
      end

      local have_cc = vim.env.CC ~= nil
        or have('cc', false)
        or have('cl', true)
        or (is_win and win_find_cl() ~= nil)

      if not have_cc and is_win and vim.fn.executable('gcc') == 1 then
        vim.env.CC = 'gcc'
        have_cc = true
      end

      ---@class table<string,boolean>
      local ret = {
        ['tree-sitter (CLI)'] = have('tree-sitter'),
        ['C compiler'] = have_cc,
        tar = have('tar'),
        curl = have('curl'),
      }
      local ok = true
      for tool, v in pairs(ret) do
        ok = ok and v
        if not v then
          local msg = '**treesitter-main** requires ' .. tool
          if tool == 'C compiler' then
            msg = msg
              .. ', install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`'
          end
          vim.notify(msg, vim.log.levels.ERROR)
        end
      end
      return ok
    end

    if not hasDependencies() then
      vim.notify('something went wrong setting up treesitter', vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      group = vim.api.nvim_create_augroup(
        'danwlker/nvim-treesitter-parser',
        { clear = true }
      ),
      callback = function()
        require('nvim-treesitter.parsers').go_tags = {
          install_info = {
            url = 'https://github.com/DanWlker/tree-sitter-go_tags',
            -- branch = 'main',
            -- files = { 'src/parser.c' },
          },
        }
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '*' },
      group = vim.api.nvim_create_augroup(
        'danwlker/nvim-treesitter-start-and-indentexpr',
        { clear = true }
      ),
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)

        if not language then return end

        if not vim.treesitter.language.add(language) then return end

        vim.treesitter.start(buf, language)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local nvim_treesitter = require('nvim-treesitter')
    nvim_treesitter.setup()
    nvim_treesitter.install({
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',

      -- install GO parsers
      'go',
      'gomod',
      'gowork',
      'gosum',
      'go_tags',

      'dart',
      'dockerfile',
      'sql',
      'json',
      'helm',
      'tsx',
      'just',
      'typescript',
      'javascript',
      'yaml',
      'css',
      'scss',
      'make',
      'graphql',
      'regex',
      'kitty',
      'toml',
      'python',
      'rust',
      'ron',
      'zsh',
    })

    -- https://www.reddit.com/r/neovim/comments/1d9gzud/comment/l7e6akp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    -- vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
  end,
}
