-- Installation Hooks has to be before vim.pack
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
      return
    end

    if
      name == 'LuaSnip' and (ev.data.kind == 'install' or ev.data.kind == 'update')
    then
      if not ev.data.active then vim.cmd.packadd('luasnip') end
      vim.cmd('make install_jsregexp')
      return
    end
  end,
})

vim.pack.add({
  -- theme
  'https://github.com/catppuccin/nvim',
  -- icons
  'https://github.com/nvim-mini/mini.icons',
  -- plenary
  'https://github.com/nvim-lua/plenary.nvim',
  -- editing
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/nvim-mini/mini.extra',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.move',
  'https://github.com/nvim-mini/mini.splitjoin',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/gbprod/substitute.nvim',
  'https://github.com/Wansmer/treesj',
  'https://github.com/folke/ts-comments.nvim',
  -- git
  'https://github.com/FabijanZulj/blame.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/f-person/git-blame.nvim',
  'https://github.com/rhysd/git-messenger.vim',
  'https://github.com/nvim-mini/mini.diff',
  'https://github.com/nvim-mini/mini-git',
  -- lang
  'https://github.com/b0o/SchemaStore.nvim',
  'https://github.com/dmmulroy/ts-error-translator.nvim',
  -- plugins
  'https://github.com/Danwlker/99',
  {
    src = 'https://github.com/Saghen/blink.cmp',
    version = vim.version.range('1.x'),
  },
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/shellRaining/hlchunk.nvim',
  'https://github.com/AndrewRadev/linediff.vim',
  {
    src = 'https://github.com/L3MON4D3/LuaSnip',
    version = vim.version.range('2.x'),
  },
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/nvim-mini/mini.hipatterns',
  'https://github.com/nacro90/numb.nvim',
  'https://github.com/kevinhwang91/nvim-bqf',
  'https://github.com/andythigpen/nvim-coverage',
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/antosha417/nvim-lsp-file-operations',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/stevearc/quicker.nvim',
  'https://github.com/DanWlker/snacks.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/mcauley-penney/visual-whitespace.nvim',
  'https://github.com/folke/which-key.nvim',
})

-- catppuccin/nvim
require('catppuccin').setup({
  auto_integrations = true,
  integrations = {
    lsp_styles = {
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
    colorful_winsep = {
      enabled = true,
      color = 'lavender',
    },
  },
  float = {
    transparent = true,
  },
  custom_highlights = function(colors)
    local custom_stuff = {
      WinSeparator = { fg = colors.surface2 },
      -- NormalFloat = { fg = colors.text, bg = colors.none },
      -- FloatBorder = { fg = colors.blue, bg = colors.none },

      -- [[ Visual whitespace ]]
      VisualNonText = { fg = colors.overlay0, bg = colors.surface1 },

      -- [[ Blink cmp ]]
      -- With border
      BlinkCmpMenu = { bg = colors.base },
      BlinkCmpMenuBorder = { fg = colors.lavender, bg = colors.base },
      -- BlinkCmpDoc = { bg = colors.base },
      -- BlinkCmpDocBorder = { fg = colors.overlay0, bg = colors.base },
      BlinkCmpDocBorder = { fg = colors.overlay0 },
      -- BlinkCmpSignatureHelpBorder = { fg = colors.overlay0, bg = colors.base },
      BlinkCmpSignatureHelpBorder = { fg = colors.overlay0 },
      -- BlinkCmpLabelMatch = { fg = colors.blue },
      -- BlinkCmpLabel = { fg = colors.text },

      -- [[ Telescope ]]
      TelescopeNormal = { bg = colors.mantle },
      TelescopePreviewTitle = {
        fg = colors.base,
        bg = colors.green,
      },
      TelescopePromptTitle = {
        fg = colors.base,
        bg = colors.pink,
      },
      TelescopeSelection = { bg = colors.surface0, fg = colors.text },
      TelescopeResultsDiffAdd = { fg = colors.green },
      TelescopeResultsDiffChange = { fg = colors.yellow },
      TelescopeResultsDiffDelete = { fg = colors.red },
      TelescopeBorder = { fg = colors.mantle, bg = colors.mantle },
      TelescopePromptBorder = { fg = colors.mantle, bg = colors.mantle },
      TelescopePromptNormal = { fg = colors.text, bg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
      TelescopePromptPrefix = { fg = colors.red, bg = colors.mantle },

      -- [[ Mini indent scope ]]
      -- MiniIndentscopeSymbol = { fg = colors.overlay2 },

      -- [[ Nvim notify ]]
      -- NotifyINFOBorder = { fg = colors.green },
      -- NotifyINFOIcon = { fg = colors.green },
      -- NotifyINFOTitle = { fg = colors.green, style = { 'italic' } },

      -- [[ Mini statusline ]]
      -- MiniStatuslineDevinfo = { bg = colors.surface0 },
      -- MiniStatuslineFileinfo = { bg = colors.surface0 },
      -- MiniStatuslineDiagnosticError = { bg = colors.surface0, fg = colors.red },
      -- MiniStatuslineDiagnosticWarn = { bg = colors.surface0, fg = colors.yellow },
      -- MiniStatuslineDiagnosticInfo = { bg = colors.surface0, fg = colors.sky },
      -- MiniStatuslineDiagnosticHint = { bg = colors.surface0, fg = colors.teal },
      -- MiniStatuslineRecording = { bg = colors.red, fg = colors.base },

      -- [[ Snacks nvim ]]
      -- SnacksIndentChunk = { fg = '#9399b2' },
      -- SnacksIndentScope = { fg = '#9399b2' },
      SnacksPickerBorder = { fg = colors.lavender },
      -- SnacksPickerBorder = { fg = colors.mantle, bg = colors.mantle },
      -- SnacksPicker = { fg = colors.text, bg = colors.mantle },
      -- SnacksPickerTitle = { fg = colors.base, bg = colors.lavender },
      --
      -- SnacksPickerBorder = { fg = colors.lavender, bg = colors.mantle },

      -- [[ Fzf lua ]]
      -- With Border
      FzfLuaBorder = { fg = colors.lavender },
      -- No Border
      -- FzfLuaNormal = { bg = colors.mantle },
      -- FzfLuaBorder = { fg = colors.mantle, bg = colors.mantle },
      -- FzfLuaTitle = {
      --   fg = colors.base,
      --   bg = colors.lavender,
      -- },
      -- FzfLuaHeaderBind = { fg = colors.rosewater },
      -- FzfLuaHeaderText = { fg = colors.green },

      -- [[ Winbar from maria's config ]]
      WinBar = { bg = colors.base },
      WinBarIndDir = { bg = colors.base },
      WinBarDir = { fg = colors.lavender, bg = colors.base, italic = true },
      WinBarSeparator = { fg = colors.lavender, bg = colors.base },
      -- WinBarDir = { fg = colors.lavender, bg = colors.surface0, italic = true },
      -- WinBarSeparator = { fg = colors.lavender, bg = colors.surface0 },
      WinBarEndSeparators = { fg = colors.base },

      -- [[ Highlight Url ]]
      -- HighlightUrl = { underline = true, fg = colors.blue, sp = colors.blue },

      -- [[ Bufferline ]]
      BufferLineBufferSelected = { bg = colors.base, sp = colors.lavender },
      BufferLineFill = { bg = colors.base },
      TabLine = { fg = colors.text, bg = colors.base },
      TabLineFill = { bg = colors.base },
      TabLineSel = { bg = colors.lavender },

      -- [[ Trouble ]]
      TroubleNormal = { fg = colors.text, bg = colors.base },

      -- [[ Diffview ]]
      DiffviewNormal = { fg = colors.text, bg = colors.base },

      -- [[ Statusline ]]
      StatusLine = { bg = colors.base },
      -- StatuslineTitle = { bg = colors.base },
      -- StatuslineLineTitle = { bg = colors.base },

      -- [[ Tabline ]]
      TabLinePillActiveLeft = { fg = colors.lavender },
      TabLinePillActiveText = { bg = colors.lavender, fg = colors.base },
      TabLinePillActiveRight = { fg = colors.lavender },
      TabLinePillInactiveLeft = { fg = colors.overlay2 },
      TabLinePillInactiveText = { bg = colors.overlay2, fg = colors.base },
      TabLinePillInactiveRight = { fg = colors.overlay2 },

      -- [[ Syntax ]]
      ['@lsp.type.variable'] = { fg = colors.text }, -- for rust to allow variable to show in println!({variable})
      -- https://www.reddit.com/r/neovim/comments/1d9gzud/comment/l7igfe0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      -- Remove comment token, because it conflicts with TS comment query.
      ['@lsp.type.comment.go'] = {},
      -- Does nothing except coloring of string literal, but conflicts with regexp parser. Remove it.
      ['@lsp.type.string.go'] = {},
    }

    for mode, color in pairs({
      Normal = colors.lavender,
      Pending = colors.pink,
      Visual = colors.yellow,
      Insert = colors.green,
      Command = colors.teal,
      Other = colors.peach,
    }) do
      custom_stuff['StatuslineMode' .. mode] = { fg = colors.base, bg = color }
      custom_stuff['StatuslineModeSeparator' .. mode] =
        { fg = color, bg = colors.base }
    end

    return custom_stuff
  end,
})
vim.cmd.colorscheme('catppuccin')

-- nvim-mini/mini.icons
local ext3_blocklist = { scm = true, txt = true, yml = true }
local ext4_blocklist = { json = true, yaml = true }
require('mini.icons').setup({
  use_file_extension = function(ext, _)
    return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
  end,
  -- file and filetype from lazyvim
  file = {
    ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
    ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
    ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
  },
  filetype = {
    gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    dotenv = { glyph = '', hl = 'MiniIconsYellow' },
  },
})
MiniIcons.tweak_lsp_kind()
MiniIcons.mock_nvim_web_devicons()

-- monaqa/dial.nvim
vim.keymap.set(
  'n',
  '<C-a>',
  function() require('dial.map').manipulate('increment', 'normal') end
)
vim.keymap.set(
  'n',
  '<C-x>',
  function() require('dial.map').manipulate('decrement', 'normal') end
)
vim.keymap.set(
  'n',
  'g<C-a>',
  function() require('dial.map').manipulate('increment', 'gnormal') end
)
vim.keymap.set(
  'n',
  'g<C-x>',
  function() require('dial.map').manipulate('decrement', 'gnormal') end
)
vim.keymap.set(
  'x',
  '<C-a>',
  function() require('dial.map').manipulate('increment', 'visual') end
)
vim.keymap.set(
  'x',
  '<C-x>',
  function() require('dial.map').manipulate('decrement', 'visual') end
)
vim.keymap.set(
  'x',
  'g<C-a>',
  function() require('dial.map').manipulate('increment', 'gvisual') end
)
vim.keymap.set(
  'x',
  'g<C-x>',
  function() require('dial.map').manipulate('decrement', 'gvisual') end
)

-- folke/flash.nvim
require('flash').setup({
  modes = {
    char = {
      enabled = false,
    },
  },
})
vim.keymap.set(
  { 'n', 'x', 'o' },
  'h',
  function()
    require('flash').jump({
      search = {
        multi_window = false,
      },
    })
  end,
  { desc = 'Flash Hop (On the character)' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  'H',
  function()
    require('flash').jump({
      search = {
        multi_window = false,
      },
      jump = {
        pos = 'end',
        inclusive = false,
      },
    })
  end,
  { desc = 'Flash Hop (One character before)' }
)

-- NMAC427/guess-indent.nvim
require('guess-indent').setup({})

-- nvim-mini/mini.extra
require('mini.extra').setup()

-- nvim-mini/mini.ai
local ai = require('mini.ai')
local miniextra = require('mini.extra')
local mini_ai_opts = {
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({ -- code block
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
    t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
    d = miniextra.gen_ai_spec.number(),
    e = { -- Word with case
      {
        '%u[%l%d]+%f[^%l%d]',
        '%f[%S][%l%d]+%f[^%l%d]',
        '%f[%P][%l%d]+%f[^%l%d]',
        '^[%l%d]+%f[^%l%d]',
      },
      '^().*()$',
    },
    g = miniextra.gen_ai_spec.buffer(), -- buffer
    u = ai.gen_spec.function_call(), -- u for "Usage"
    U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
    l = miniextra.gen_ai_spec.line(),
  },
  mappings = {
    around_next = '',
    inside_next = '',
    around_last = '',
    inside_last = '',
  },
}
ai.setup(mini_ai_opts)
local function ai_whichkey(wopts)
  local ok, module = pcall(function() return require('which-key') end)
  if not ok then return end

  local objects = {
    { ' ', desc = 'whitespace' },
    { '"', desc = '" string' },
    { "'", desc = "' string" },
    { '(', desc = '() block' },
    { ')', desc = '() block with ws' },
    { '<', desc = '<> block' },
    { '>', desc = '<> block with ws' },
    { '?', desc = 'user prompt' },
    { 'U', desc = 'use/call without dot' },
    { '[', desc = '[] block' },
    { ']', desc = '[] block with ws' },
    { '_', desc = 'underscore' },
    { '`', desc = '` string' },
    { 'a', desc = 'argument' },
    { 'b', desc = ')]} block' },
    { 'c', desc = 'class' },
    { 'd', desc = 'digit(s)' },
    { 'e', desc = 'CamelCase / snake_case' },
    { 'f', desc = 'function' },
    { 'g', desc = 'entire file' },
    { 'o', desc = 'block, conditional, loop' },
    { 'q', desc = 'quote `"\'' },
    { 't', desc = 'tag' },
    { 'l', desc = 'line' },
    { 'u', desc = 'use/call' },
    { '{', desc = '{} block' },
    { '}', desc = '{} with ws' },
  }

  local ret = { mode = { 'o', 'x' } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend('force', {}, {
    around = 'a',
    inside = 'i',
    -- around_next = 'an',
    -- inside_next = 'in',
    -- around_last = 'al',
    -- inside_last = 'il',
  }, wopts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    if prefix == '' then goto continue end
    name = name:gsub('^around_', ''):gsub('^inside_', '')
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == 'i' then desc = desc:gsub(' with ws', '') end
      ret[#ret + 1] = { prefix .. obj[1], desc = desc }
    end
    ::continue::
  end

  module.add(ret, { notify = false })
end
ai_whichkey(mini_ai_opts)

-- nvim-mini/mini.move
require('mini.move').setup({
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '<',
    right = '>',
    down = '<S-Down>',
    up = '<S-Up>',

    -- Move current line in Normal mode
    line_left = '',
    line_right = '',
    line_down = '',
    line_up = '',
  },
})

-- nvim-mini/mini.splitjoin
require('mini.splitjoin').setup({
  mappings = {
    toggle = 'jT',
    split = 'jS',
    join = 'jJ',
  },
})
local gen_hook = MiniSplitjoin.gen_hook
local add_comma_curly = gen_hook.add_trailing_separator()
local del_comma_curly = gen_hook.del_trailing_separator()
vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_comma_curly } },
  join = { hooks_post = { del_comma_curly } },
}

-- nvim-mini/mini.surround
require('mini.surround').setup({
  mappings = {
    add = 'l', -- Add surrounding in Normal and Visual modes
    delete = 'dl', -- Delete surrounding
    find = '', -- Find surrounding (to the right)
    find_left = '', -- Find surrounding (to the left)
    highlight = '', -- Highlight surrounding
    replace = 'cl', -- Replace surrounding
  },
})

-- nvim-treesitter/nvim-treesitter
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
---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end
local available_parsers = require('nvim-treesitter').get_available()
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

    local installed_parsers = require('nvim-treesitter').get_installed('parsers')
    if vim.tbl_contains(installed_parsers, language) then
      -- enable the parser if it is installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
      require('nvim-treesitter')
        .install(language)
        :await(function() treesitter_try_attach(buf, language) end)
    else
      -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
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

-- nvim-treesitter-textobjects
require('nvim-treesitter-textobjects').setup()

-- gbprod/substitute.nvim
require('substitute').setup({
  -- yank_substituted_text = true,
  highlight_substituted_text = {
    timer = 150,
  },
})
vim.keymap.set('n', 's', require('substitute').operator, { desc = 'Substitute' })
vim.keymap.set('x', 's', require('substitute').visual, { desc = 'Substitute' })
vim.keymap.set(
  { 'n', 'x' },
  'S',
  require('substitute').eol,
  { desc = 'Substitute to eol' }
)
vim.keymap.set('n', 'ss', require('substitute').line, { desc = 'Substitute line' })
vim.keymap.set(
  'n',
  'gs',
  require('substitute.exchange').operator,
  { desc = 'Substitute exchange' }
)
vim.keymap.set(
  'x',
  'gs',
  require('substitute.exchange').visual,
  { desc = 'Substitute exchange' }
)
vim.keymap.set(
  'n',
  'gss',
  require('substitute.exchange').line,
  { desc = 'Substitute exchange line' }
)

-- Wansmer/treesj
local treesj = require('treesj')
treesj.setup({ use_default_keymaps = false })
local tsj_langs = require('treesj.langs')['presets']
local function get_pos_lang()
  local c = vim.api.nvim_win_get_cursor(0)
  local range = { c[1] - 1, c[2], c[1] - 1, c[2] }
  local buf = vim.api.nvim_get_current_buf()
  local ok, parser = pcall(
    vim.treesitter.get_parser,
    buf,
    vim.treesitter.language.get_lang(vim.bo[buf].ft)
  )
  if not ok or parser == nil then return '' end
  return parser:language_for_range(range):lang()
end
vim.keymap.set('n', 'jt', function()
  local lang = get_pos_lang()
  if lang ~= '' and tsj_langs[lang] then
    treesj.toggle()
  else
    require('mini.splitjoin').toggle() -- lazy load, only load if need to fallback
  end
end)
vim.keymap.set('n', 'js', function()
  local lang = get_pos_lang()
  if lang ~= '' and tsj_langs[lang] then
    treesj.split()
  else
    require('mini.splitjoin').split() -- lazy load, only load if need to fallback
  end
end)
vim.keymap.set('n', 'jj', function()
  local lang = get_pos_lang()
  if lang ~= '' and tsj_langs[lang] then
    treesj.join()
  else
    require('mini.splitjoin').join() -- lazy load, only load if need to fallback
  end
end)

-- folke/ts-comments.nvim
require('ts-comments').setup({
  lang = {
    vue = {
      '<!-- %s -->',
      script_element = '// %s',
    },
    kitty = '# %s',
  },
})

-- FabijanZulj/blame.nvim
require('blame').setup({
  blame_options = { '-w' },
})
vim.keymap.set(
  'n',
  '<leader>gl',
  '<cmd>BlameToggle window<cr>',
  { desc = 'Git Blame List' }
)

-- sindrets/diffview.nvim
require('diffview').setup({
  view = {
    default = {
      layout = 'diff2_vertical',
    },
  },
})
vim.keymap.set(
  'n',
  '<leader>gh',
  '<cmd>DiffviewFileHistory<cr>',
  { desc = 'Git History' }
)
vim.keymap.set(
  'n',
  '<leader>gf',
  '<cmd>DiffviewFileHistory %<cr>',
  { desc = 'Git File Only History' }
)

-- f-person/git-blame.nvim
require('gitblame').setup({
  enabled = false,
})
vim.keymap.set(
  'n',
  '<leader>gcs',
  '<cmd>GitBlameCopySHA<cr>',
  { desc = 'Git Copy SHA' }
)
vim.keymap.set(
  'n',
  '<leader>gcf',
  '<cmd>GitBlameCopyFileURL<cr>',
  { desc = 'Git Copy File URL' }
)
vim.keymap.set(
  'n',
  '<leader>gcc',
  '<cmd>GitBlameCopyCommitURL<cr>',
  { desc = 'Git Copy Commit URL' }
)
vim.keymap.set(
  'n',
  '<leader>gof',
  '<cmd>GitBlameOpenFileURL<cr>',
  { desc = 'Git Open File URL' }
)
vim.keymap.set(
  'n',
  '<leader>goc',
  '<cmd>GitBlameOpenCommitURL<cr>',
  { desc = 'Git Open Commit URL' }
)

-- rhysd/git-messenger.vim
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
vim.keymap.set('n', '<leader>gb', '<Plug>(git-messenger)', { desc = 'Git Blame' })

-- nvim-mini/mini.diff
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = {
      add = '▎',
      change = '▎',
      delete = '',
    },
  },
})
vim.keymap.set(
  'n',
  '<leader>gd',
  function() require('mini.diff').toggle_overlay(0) end,
  { desc = 'Git Diff' }
)

-- nvim-mini/mini-git
require('mini.git').setup({})
-- Use only HEAD name as summary string
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniGitUpdated',
  group = vim.api.nvim_create_augroup('danwlker/mini-git-head', { clear = true }),
  callback = function(data)
    -- Utilize buffer-local table summary
    local summary = vim.b[data.buf].minigit_summary
    vim.b[data.buf].minigit_summary_string = summary.head_name or ''
  end,
})

-- dmmulroy/ts-error-translator.nvim
require('ts-error-translator').setup({
  -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
  auto_attach = true,
  -- LSP server names to translate diagnostics for (default shown below)
  servers = {
    'astro',
    'svelte',
    'ts_ls',
    'tsserver', -- deprecated, use ts_ls
    'typescript-tools',
    'volar',
    'vtsls',
  },
})

-- Danwlker/99
local _99 = require('99')
-- For logging that is to a file if you wish to trace through requests
-- for reporting bugs, i would not rely on this, but instead the provided
-- logging mechanisms within 99.  This is for more debugging purposes
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)
_99.setup({
  provider = _99.Providers.CrushProvider, -- default: OpenCodeProvider
  logger = {
    level = _99.DEBUG,
    path = '/tmp/' .. basename .. '.99.debug',
    print_on_error = true,
  },
  -- When setting this to something that is not inside the CWD tools
  -- such as claude code or opencode will have permission issues
  -- and generation will fail refer to tool documentation to resolve
  -- https://opencode.ai/docs/permissions/#external-directories
  -- https://code.claude.com/docs/en/permissions#read-and-edit
  tmp_dir = './tmp',

  --- Completions: #rules and @files in the prompt buffer
  completion = {
    -- I am going to disable these until i understand the
    -- problem better.  Inside of cursor rules there is also
    -- application rules, which means i need to apply these
    -- differently
    -- cursor_rules = "<custom path to cursor rules>"

    --- A list of folders where you have your own SKILL.md
    --- Expected format:
    --- /path/to/dir/<skill_name>/SKILL.md
    ---
    --- Example:
    --- Input Path:
    --- "scratch/custom_rules/"
    ---
    --- Output Rules:
    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
    --- ... the other rules in that dir ...
    ---
    custom_rules = {
      'scratch/custom_rules/',
    },

    --- Configure @file completion (all fields optional, sensible defaults)
    files = {
      -- enabled = true,
      -- max_file_size = 102400,     -- bytes, skip files larger than this
      -- max_files = 5000,            -- cap on total discovered files
      -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
    },
    --- File Discovery:
    --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
    --- - Non-git repos: Falls back to filesystem scanning with manual excludes
    --- - Both methods apply the configured `exclude` list on top of gitignore

    --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
    source = 'native', -- "native" (default), "cmp", or "blink"
  },

  --- WARNING: if you change cwd then this is likely broken
  --- ill likely fix this in a later change
  ---
  --- md_files is a list of files to look for and auto add based on the location
  --- of the originating request.  That means if you are at /foo/bar/baz.lua
  --- the system will automagically look for:
  --- /foo/bar/AGENT.md
  --- /foo/AGENT.md
  --- assuming that /foo is project root (based on cwd)
  md_files = {
    'AGENT.md',
  },
})
local trigger = '<leader>a'
-- take extra note that i have visual selection only in v mode
-- technically whatever your last visual selection is, will be used
-- so i have this set to visual mode so i dont screw up and use an
-- old visual selection
--
-- likely ill add a mode check and assert on required visual mode
-- so just prepare for it now
vim.keymap.set(
  'x',
  trigger .. 'v',
  function() _99.visual({}) end,
  { desc = 'Ai Visual' }
)
--- if you have a request you dont want to make any changes, just cancel it
vim.keymap.set(
  'n',
  trigger .. 'x',
  function() _99.stop_all_requests() end,
  { desc = 'Ai Stop All Requests' }
)
vim.keymap.set(
  'n',
  trigger .. 'f',
  function() _99.search({}) end,
  { desc = 'Ai Find' }
)
vim.keymap.set(
  'n',
  trigger .. 'm',
  function() require('99.extensions.snacks').select_model() end,
  { desc = 'Ai Select Model' }
)
vim.keymap.set(
  'n',
  trigger .. 'p',
  function() require('99.extensions.snacks').select_provider() end,
  { desc = 'Ai Select Provider' }
)

-- Saghen/blink.cmp
require('blink.cmp').setup({
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
      mysql = { 'dadbod' },
      plsql = { 'dadbod' },
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
        -- align_to = 'cursor',
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
          { 'label', 'label_description', gap = 1 },
          { 'kind' },
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
})

-- stevearc/conform.nvim
local prettier = { 'prettierd', 'prettier', stop_after_first = true }
-- local disable_filetypes = {}
local prefer_lsp = {}
local fallback_to_lsp = { ['lua'] = true }
vim.keymap.set(
  'n',
  '<leader>tf',
  function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  { desc = 'Toggle format' }
)
vim.api.nvim_create_user_command(
  'ConformFormat',
  function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
  { desc = 'Format buffer' }
)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
require('conform').setup({
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Reenable when needed
    -- if disable_filetypes[vim.bo[bufnr].filetype] then
    --   return nil
    -- end
    if vim.b[bufnr].disable_autoformat then return end

    local to_return = { timeout_ms = 500 }
    -- Reenable when needed
    if prefer_lsp[vim.bo[bufnr].filetype] then
      to_return['lsp_format'] = 'prefer'
    elseif fallback_to_lsp[vim.bo[bufnr].filetype] then
      to_return['lsp_format'] = 'fallback'
    else
      -- -- should be safe to put this as default, most people and projects have lsp
      -- -- and lsp is usually the priority? I think
      to_return['lsp_format'] = 'last'
      --
    end

    -- Why not use 'fallback'?
    -- Gopls should be prioritised
    -- And usually LSP is done by the language designers? so.. in that case
    -- if they provide a formatter, we should use it.
    -- 'first' also not suitable for the same reason
    -- 'prefer' is different from not specfiying because not specfiying means uting trim_whitespace and trim_newlines
    -- 'never' is in cases like maybe javascript? where we only want to use prettier but in this case i think 'last' works as well

    return to_return
  end,
  formatters = {
    sqlfluff = {
      args = { 'format', '--dialect=ansi', '-' },
    },
    -- ['markdown-toc'] = {
    --   condition = function(_, ctx)
    --     for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
    --       if line:find '<!%-%- toc %-%->' then
    --         return true
    --       end
    --     end
    --   end,
    -- },
    -- ['markdownlint-cli2'] = {
    --   condition = function(_, ctx)
    --     local diag = vim.tbl_filter(function(d)
    --       return d.source == 'markdownlint'
    --     end, vim.diagnostic.get(ctx.buf))
    --     return #diag > 0
    --   end,
    -- },
    prettier = { require_cwd = true },
  },
  formatters_by_ft = {
    c = { 'clang-format' },
    -- go = { 'goimports' }, -- 'gofumpt' is lsp handled, slows down gopls if configured here
    javascript = prettier,
    javascriptreact = prettier,
    json = prettier,
    jsonc = prettier,
    lua = { 'stylua' },
    markdown = prettier, -- markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
    css = prettier,
    scss = prettier,
    sql = { 'sqlfluff' },
    typescript = prettier,
    typescriptreact = prettier,
    yaml = prettier,
    python = {
      -- To fix auto-fixable lint errors.
      'ruff_fix',
      -- To run the Ruff formatter.
      'ruff_format',
      -- To organize the imports.
      'ruff_organize_imports',
    },
    graphql = prettier,
    html = prettier,
    vue = prettier,
    rust = { 'rustfmt' },
    ['_'] = { 'trim_whitespace', 'trim_newlines' },
  },
})

-- shellRaining/hlchunk.nvim
require('hlchunk').setup({
  chunk = {
    chars = {
      horizontal_line = '─',
      vertical_line = '│',
      left_top = '╭',
      left_bottom = '╰',
      right_arrow = '─',
    },
    style = {
      '#9399b2',
      '#eba0ac',
    },
    enable = true,
    duration = 0,
    delay = 0,
  },
  indent = {
    enable = false,
  },
  line_num = {
    enable = false,
  },
  blank = {
    enable = false,
  },
})

-- L3MON4D3/LuaSnip
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.filetype_extend('javascriptreact', { 'html' })
luasnip.filetype_extend('typescriptreact', { 'html' })
luasnip.filetype_extend('svelte', { 'html' })
luasnip.filetype_extend('vue', { 'html' })
luasnip.filetype_extend('php', { 'html' })
luasnip.filetype_extend('javascript', { 'javascriptreact' })
luasnip.filetype_extend('typescript', { 'typescriptreact' })
luasnip.filetype_extend('dart', { 'flutter' })
require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })

-- mason-org/mason.nvim
require('mason').setup({
  ui = {
    icons = {
      package_pending = ' ',
      package_installed = ' ',
      package_uninstalled = ' ',
    },
  },
})

-- mason-org/mason-lspconfig.nvim
require('mason-lspconfig').setup({
  automatic_enable = false,
})

-- WhoIsSethDaniel/mason-tool-installer.nvim
require('mason-tool-installer').setup({
  ensure_installed = {
    'basedpyright',
    'tombi',
    'helm_ls',
    'marksman',
    'yamlls',
    'jsonls',
    'dockerls',
    'docker_compose_language_service',
    'clangd',
    'gopls',
    'superhtml',
    'cssls',
    'eslint',
    'vtsls',
    'emmet_language_server',
    'lua_ls',
    'tailwindcss',
    'bashls',
    'bacon_ls',

    -- tools
    'stylua',
    'markdownlint-cli2',
    -- 'markdown-toc',
    'prettierd',
    'prettier',
    'golangci-lint',
    'clang-format',
    'yamllint',
    'gofumpt',
    'hadolint',
    'sqlfluff',
    'delve',
    'shellcheck', --used by bashls
    'shfmt', --used by bashls
    -- 'goimports',
    -- 'tree-sitter-cli', -- don't use this, use brew installed one
    'ruff',
    -- 'yamlfmt',
    'bacon', -- used by bacon_ls
    -- 'rustfmt', -- deprecated, install this using rustup
  },
})

-- nvim-mini/mini.hipatterns
local hl = {}
local colors = {
  slate = {
    [50] = 'f8fafc',
    [100] = 'f1f5f9',
    [200] = 'e2e8f0',
    [300] = 'cbd5e1',
    [400] = '94a3b8',
    [500] = '64748b',
    [600] = '475569',
    [700] = '334155',
    [800] = '1e293b',
    [900] = '0f172a',
    [950] = '020617',
  },

  gray = {
    [50] = 'f9fafb',
    [100] = 'f3f4f6',
    [200] = 'e5e7eb',
    [300] = 'd1d5db',
    [400] = '9ca3af',
    [500] = '6b7280',
    [600] = '4b5563',
    [700] = '374151',
    [800] = '1f2937',
    [900] = '111827',
    [950] = '030712',
  },

  zinc = {
    [50] = 'fafafa',
    [100] = 'f4f4f5',
    [200] = 'e4e4e7',
    [300] = 'd4d4d8',
    [400] = 'a1a1aa',
    [500] = '71717a',
    [600] = '52525b',
    [700] = '3f3f46',
    [800] = '27272a',
    [900] = '18181b',
    [950] = '09090B',
  },

  neutral = {
    [50] = 'fafafa',
    [100] = 'f5f5f5',
    [200] = 'e5e5e5',
    [300] = 'd4d4d4',
    [400] = 'a3a3a3',
    [500] = '737373',
    [600] = '525252',
    [700] = '404040',
    [800] = '262626',
    [900] = '171717',
    [950] = '0a0a0a',
  },

  stone = {
    [50] = 'fafaf9',
    [100] = 'f5f5f4',
    [200] = 'e7e5e4',
    [300] = 'd6d3d1',
    [400] = 'a8a29e',
    [500] = '78716c',
    [600] = '57534e',
    [700] = '44403c',
    [800] = '292524',
    [900] = '1c1917',
    [950] = '0a0a0a',
  },

  red = {
    [50] = 'fef2f2',
    [100] = 'fee2e2',
    [200] = 'fecaca',
    [300] = 'fca5a5',
    [400] = 'f87171',
    [500] = 'ef4444',
    [600] = 'dc2626',
    [700] = 'b91c1c',
    [800] = '991b1b',
    [900] = '7f1d1d',
    [950] = '450a0a',
  },

  orange = {
    [50] = 'fff7ed',
    [100] = 'ffedd5',
    [200] = 'fed7aa',
    [300] = 'fdba74',
    [400] = 'fb923c',
    [500] = 'f97316',
    [600] = 'ea580c',
    [700] = 'c2410c',
    [800] = '9a3412',
    [900] = '7c2d12',
    [950] = '431407',
  },

  amber = {
    [50] = 'fffbeb',
    [100] = 'fef3c7',
    [200] = 'fde68a',
    [300] = 'fcd34d',
    [400] = 'fbbf24',
    [500] = 'f59e0b',
    [600] = 'd97706',
    [700] = 'b45309',
    [800] = '92400e',
    [900] = '78350f',
    [950] = '451a03',
  },

  yellow = {
    [50] = 'fefce8',
    [100] = 'fef9c3',
    [200] = 'fef08a',
    [300] = 'fde047',
    [400] = 'facc15',
    [500] = 'eab308',
    [600] = 'ca8a04',
    [700] = 'a16207',
    [800] = '854d0e',
    [900] = '713f12',
    [950] = '422006',
  },

  lime = {
    [50] = 'f7fee7',
    [100] = 'ecfccb',
    [200] = 'd9f99d',
    [300] = 'bef264',
    [400] = 'a3e635',
    [500] = '84cc16',
    [600] = '65a30d',
    [700] = '4d7c0f',
    [800] = '3f6212',
    [900] = '365314',
    [950] = '1a2e05',
  },

  green = {
    [50] = 'f0fdf4',
    [100] = 'dcfce7',
    [200] = 'bbf7d0',
    [300] = '86efac',
    [400] = '4ade80',
    [500] = '22c55e',
    [600] = '16a34a',
    [700] = '15803d',
    [800] = '166534',
    [900] = '14532d',
    [950] = '052e16',
  },

  emerald = {
    [50] = 'ecfdf5',
    [100] = 'd1fae5',
    [200] = 'a7f3d0',
    [300] = '6ee7b7',
    [400] = '34d399',
    [500] = '10b981',
    [600] = '059669',
    [700] = '047857',
    [800] = '065f46',
    [900] = '064e3b',
    [950] = '022c22',
  },

  teal = {
    [50] = 'f0fdfa',
    [100] = 'ccfbf1',
    [200] = '99f6e4',
    [300] = '5eead4',
    [400] = '2dd4bf',
    [500] = '14b8a6',
    [600] = '0d9488',
    [700] = '0f766e',
    [800] = '115e59',
    [900] = '134e4a',
    [950] = '042f2e',
  },

  cyan = {
    [50] = 'ecfeff',
    [100] = 'cffafe',
    [200] = 'a5f3fc',
    [300] = '67e8f9',
    [400] = '22d3ee',
    [500] = '06b6d4',
    [600] = '0891b2',
    [700] = '0e7490',
    [800] = '155e75',
    [900] = '164e63',
    [950] = '083344',
  },

  sky = {
    [50] = 'f0f9ff',
    [100] = 'e0f2fe',
    [200] = 'bae6fd',
    [300] = '7dd3fc',
    [400] = '38bdf8',
    [500] = '0ea5e9',
    [600] = '0284c7',
    [700] = '0369a1',
    [800] = '075985',
    [900] = '0c4a6e',
    [950] = '082f49',
  },

  blue = {
    [50] = 'eff6ff',
    [100] = 'dbeafe',
    [200] = 'bfdbfe',
    [300] = '93c5fd',
    [400] = '60a5fa',
    [500] = '3b82f6',
    [600] = '2563eb',
    [700] = '1d4ed8',
    [800] = '1e40af',
    [900] = '1e3a8a',
    [950] = '172554',
  },

  indigo = {
    [50] = 'eef2ff',
    [100] = 'e0e7ff',
    [200] = 'c7d2fe',
    [300] = 'a5b4fc',
    [400] = '818cf8',
    [500] = '6366f1',
    [600] = '4f46e5',
    [700] = '4338ca',
    [800] = '3730a3',
    [900] = '312e81',
    [950] = '1e1b4b',
  },

  violet = {
    [50] = 'f5f3ff',
    [100] = 'ede9fe',
    [200] = 'ddd6fe',
    [300] = 'c4b5fd',
    [400] = 'a78bfa',
    [500] = '8b5cf6',
    [600] = '7c3aed',
    [700] = '6d28d9',
    [800] = '5b21b6',
    [900] = '4c1d95',
    [950] = '2e1065',
  },

  purple = {
    [50] = 'faf5ff',
    [100] = 'f3e8ff',
    [200] = 'e9d5ff',
    [300] = 'd8b4fe',
    [400] = 'c084fc',
    [500] = 'a855f7',
    [600] = '9333ea',
    [700] = '7e22ce',
    [800] = '6b21a8',
    [900] = '581c87',
    [950] = '3b0764',
  },

  fuchsia = {
    [50] = 'fdf4ff',
    [100] = 'fae8ff',
    [200] = 'f5d0fe',
    [300] = 'f0abfc',
    [400] = 'e879f9',
    [500] = 'd946ef',
    [600] = 'c026d3',
    [700] = 'a21caf',
    [800] = '86198f',
    [900] = '701a75',
    [950] = '4a044e',
  },

  pink = {
    [50] = 'fdf2f8',
    [100] = 'fce7f3',
    [200] = 'fbcfe8',
    [300] = 'f9a8d4',
    [400] = 'f472b6',
    [500] = 'ec4899',
    [600] = 'db2777',
    [700] = 'be185d',
    [800] = '9d174d',
    [900] = '831843',
    [950] = '500724',
  },

  rose = {
    [50] = 'fff1f2',
    [100] = 'ffe4e6',
    [200] = 'fecdd3',
    [300] = 'fda4af',
    [400] = 'fb7185',
    [500] = 'f43f5e',
    [600] = 'e11d48',
    [700] = 'be123c',
    [800] = '9f1239',
    [900] = '881337',
    [950] = '4c0519',
  },
}
-- reset hl groups when colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function() hl = {} end,
})
local mini_hipatterns = require('mini.hipatterns')
mini_hipatterns.setup({
  highlighters = {
    hex_color = mini_hipatterns.gen_highlighter.hex_color({
      priority = 2000,
    }),
    shorthand = {
      pattern = '()#%x%x%x()%f[^%x%w]',
      group = function(_, _, data)
        ---@type string
        local match = data.full_match
        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
        local hex_color = '#' .. r .. r .. g .. g .. b .. b

        return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
      end,
      extmark_opts = { priority = 2000 },
    },
    tailwind = {
      pattern = function()
        if
          not vim.tbl_contains({
            'astro',
            'css',
            'heex',
            'html',
            'html-eex',
            'javascript',
            'javascriptreact',
            'rust',
            'svelte',
            'typescript',
            'typescriptreact',
            'vue',
          }, vim.bo.filetype)
        then
          return
        end
        -- if opts.tailwind.style == 'full' then
        --   return '%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]'
        -- elseif opts.tailwind.style == 'compact' then
        return '%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]'
        -- end
      end,
      group = function(_, _, m)
        ---@type string
        local match = m.full_match
        ---@type string, number
        local color, shade = match:match('[%w-]+%-([a-z%-]+)%-(%d+)')
        shade = tonumber(shade)
        local bg = vim.tbl_get(colors, color, shade)
        if bg then
          local hlEntry = 'MiniHipatternsTailwind' .. color .. shade
          if not hl[hlEntry] then
            hl[hlEntry] = true
            local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
            local fg = vim.tbl_get(colors, color, bg_shade)
            vim.api.nvim_set_hl(0, hlEntry, { bg = '#' .. bg, fg = '#' .. fg })
          end
          return hlEntry
        end
      end,
      extmark_opts = { priority = 2000 },
    },
  },
})

-- nacro90/numb.nvim
require('numb').setup()

-- kevinhwang91/nvim-bqf
require('bqf').setup()

-- andythigpen/nvim-coverage
require('coverage').setup({
  commands = true,
  auto_reload = true,
  highlights = {
    covered = { fg = '#C3E88D' },
    uncovered = { fg = '#F07178' },
  },
  signs = {
    covered = { hl = 'CoverageCovered', text = '▎' },
    uncovered = { hl = 'CoverageUncovered', text = '▎' },
  },
  summary = {
    min_coverage = 80.0,
  },
})

-- igorlfs/nvim-dap-view
require('dap-view').setup({
  winbar = {
    sections = {
      'scopes',
      'breakpoints',
      'threads',
      'exceptions',
      'repl',
      'console',
    },
    default_section = 'scopes',
  },
  switchbuf = 'usetab,uselast',
})
vim.keymap.set(
  'n',
  '<F7>',
  '<cmd>DapViewToggle<cr>',
  { desc = 'Debug: See last session result.' }
)

-- theHamsta/nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup({
  virt_text_pos = 'eol',
})

-- mfussenegger/nvim-dap
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = vim.g.have_nerd_font
    and {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }
  or {
    Breakpoint = '●',
    BreakpointCondition = '⊜',
    BreakpointRejected = '⊘',
    LogPoint = '◆',
    Stopped = '⭔',
  }
for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local dap_hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = dap_hl, numhl = dap_hl })
end
vim.keymap.set(
  'n',
  '<F5>',
  require('dap').continue,
  { desc = 'Debug: Start/Continue' }
)
vim.keymap.set('n', '<F1>', require('dap').step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', require('dap').step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', require('dap').step_out, { desc = 'Debug: Step Out' })
vim.keymap.set(
  'n',
  '<leader>b',
  require('dap').toggle_breakpoint,
  { desc = 'Debug: Toggle Breakpoint' }
)
vim.keymap.set(
  'n',
  '<leader>B',
  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = 'Debug: Set Breakpoint' }
)

-- mfussenegger/nvim-lint
local lint = require('lint')
vim.api.nvim_create_user_command('LintInfo', function()
  local filetype = vim.bo.filetype
  local linters = lint.linters_by_ft[filetype]

  if linters then
    vim.notify('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
  else
    vim.notify('No linters configured for filetype: ' .. filetype)
  end
end, {})
-- yamllint
local yamllint = lint.linters.yamllint
table.insert(yamllint.args, '-d')
table.insert(yamllint.args, '{extends: default, rules: {braces: disable}}')
-- golangcilint
-- local golangcilint = lint.linters.golangcilint
-- -- Add wsl to golangcilint
-- -- https://github.com/bombsimon/wsl?tab=readme-ov-file
-- table.insert(golangcilint.args, '--enable')
-- table.insert(golangcilint.args, 'wsl')
lint.linters_by_ft = {
  markdown = { 'markdownlint-cli2' },
  go = { 'golangcilint' },
  yaml = { 'yamllint' },
  dockerfile = { 'hadolint' },
  sql = { 'sqlfluff' },
  mysql = { 'sqlfluff' },
  plsql = { 'sqlfluff' },
  python = { 'ruff' },
}
-- To allow other plugins to add linters to require('lint').linters_by_ft,
-- instead set linters_by_ft like this:
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- However, note that this will enable a set of default linters,
-- which will cause errors unless these tools are available:
-- {
--   clojure = { "clj-kondo" },
--   inko = { "inko" },
--   janet = { "janet" },
--   json = { "jsonlint" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- You can disable the default linters by setting their filetypes to nil:
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil
--
-- Create autocommand which carries out the actual linting
-- on the specified events.
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('danwlker/lint', { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})

-- nvim-tree/nvim-tree.lua
local tree_api = require('nvim-tree.api')
vim.keymap.set('n', '\\', function()
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt =
    vim.api.nvim_get_option_value('filetype', { buf = currentBuf })
  if currentBufFt == 'NvimTree' then
    tree_api.tree.toggle()
  else
    tree_api.tree.open()
  end
end, { desc = 'Toggle/Focus NvimTree' })
local HEIGHT_RATIO = 0.85 -- You can change this
local WIDTH_RATIO = 0.79 -- You can change this too
local floating = true
local view = {
  -- relativenumber = false,
  -- width = 45,
  adaptive_size = true,
  side = 'right',
}
if floating then
  view = {
    -- relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
          - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function() return math.floor(vim.opt.columns:get() * WIDTH_RATIO) end,
  }
end
require('nvim-tree').setup({
  on_attach = function(bufnr)
    local function nvim_tree_opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    vim.keymap.set('n', 'K', tree_api.node.show_info_popup, nvim_tree_opts('Info'))
    vim.keymap.set(
      'n',
      '<C-t>',
      tree_api.node.open.tab,
      nvim_tree_opts('Open: New Tab')
    )
    vim.keymap.set(
      'n',
      '<C-v>',
      tree_api.node.open.vertical,
      nvim_tree_opts('Open: Vertical Split')
    )
    vim.keymap.set(
      'n',
      '<C-s>',
      tree_api.node.open.horizontal,
      nvim_tree_opts('Open: Horizontal Split')
    )
    vim.keymap.set(
      'n',
      '<BS>',
      tree_api.node.navigate.parent_close,
      nvim_tree_opts('Close Directory')
    )
    vim.keymap.set('n', '<CR>', tree_api.node.open.edit, nvim_tree_opts('Open'))
    vim.keymap.set('n', '.', tree_api.node.run.cmd, nvim_tree_opts('Run Command'))
    vim.keymap.set(
      'n',
      'a',
      tree_api.fs.create,
      nvim_tree_opts('Create File Or Directory')
    )
    vim.keymap.set(
      'n',
      'bd',
      tree_api.marks.bulk.delete,
      nvim_tree_opts('Delete Bookmarked')
    )
    vim.keymap.set(
      'n',
      'bD',
      tree_api.marks.bulk.trash,
      nvim_tree_opts('Trash Bookmarked')
    )
    vim.keymap.set(
      'n',
      'bmv',
      tree_api.marks.bulk.move,
      nvim_tree_opts('Move Bookmarked')
    )
    vim.keymap.set(
      'n',
      'B',
      tree_api.filter.no_buffer.toggle,
      nvim_tree_opts('Toggle Filter: No Buffer')
    )
    vim.keymap.set('n', 'y', tree_api.fs.copy.node, nvim_tree_opts('Copy'))
    vim.keymap.set('n', 'd', tree_api.fs.remove, nvim_tree_opts('Delete'))
    vim.keymap.set('n', 'D', tree_api.fs.trash, nvim_tree_opts('Trash'))
    vim.keymap.set('n', 'E', tree_api.tree.expand_all, nvim_tree_opts('Expand All'))
    vim.keymap.set(
      'n',
      'F',
      tree_api.filter.live.clear,
      nvim_tree_opts('Live Filter: Clear')
    )
    vim.keymap.set(
      'n',
      'f',
      tree_api.filter.live.start,
      nvim_tree_opts('Live Filter: Start')
    )
    vim.keymap.set('n', 'g?', tree_api.tree.toggle_help, nvim_tree_opts('Help'))
    vim.keymap.set(
      'n',
      'H',
      tree_api.filter.dotfiles.toggle,
      nvim_tree_opts('Toggle Filter: Dotfiles')
    )
    vim.keymap.set(
      'n',
      'I',
      tree_api.filter.git.ignored.toggle,
      nvim_tree_opts('Toggle Filter: Git Ignore')
    )
    vim.keymap.set(
      'n',
      'M',
      tree_api.filter.no_bookmark.toggle,
      nvim_tree_opts('Toggle Filter: No Bookmark')
    )
    vim.keymap.set(
      'n',
      'm',
      tree_api.marks.toggle,
      nvim_tree_opts('Toggle Bookmark')
    )
    vim.keymap.set('n', 'p', tree_api.fs.paste, nvim_tree_opts('Paste'))
    vim.keymap.set(
      'n',
      'P',
      tree_api.node.navigate.parent,
      nvim_tree_opts('Parent Directory')
    )
    vim.keymap.set('n', 'q', tree_api.tree.close, nvim_tree_opts('Close'))
    vim.keymap.set('n', 'r', tree_api.fs.rename_full, nvim_tree_opts('Rename'))
    vim.keymap.set('n', 'R', tree_api.tree.reload, nvim_tree_opts('Refresh'))
    vim.keymap.set('n', 'W', tree_api.tree.collapse_all, nvim_tree_opts('Collapse'))
    vim.keymap.set('n', 'x', tree_api.fs.cut, nvim_tree_opts('Cut'))
    vim.keymap.set('n', 'gc', tree_api.fs.copy.filename, nvim_tree_opts('Copy Name'))
    vim.keymap.set(
      'n',
      'c',
      tree_api.fs.copy.relative_path,
      nvim_tree_opts('Copy Relative Path')
    )
    vim.keymap.set(
      'n',
      'C',
      tree_api.fs.copy.absolute_path,
      nvim_tree_opts('Copy Absolute Path')
    )
  end,
  disable_netrw = true,
  hijack_netrw = true,
  sort = {
    sorter = 'case_sensitive',
  },
  view = view,
  renderer = {
    group_empty = true,
    indent_markers = { enable = true },
    highlight_git = 'all',
    -- root_folder_label = ':t',
    -- root_folder_label = ':~:s?$?//?',
    root_folder_label = ':~',
  },
  actions = {
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
  },
  filters = {
    custom = { 'node_modules', '^\\.git$', '^\\.github$' },
  },
  git = {
    enable = false,
  },
  update_focused_file = {
    enable = true,
  },
})
if floating then
  vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = vim.api.nvim_create_augroup(
      'danwlker/nvim-tree-resize',
      { clear = true }
    ),
    callback = function()
      if require('nvim-tree.view').is_visible() then
        tree_api.tree.close()
        tree_api.tree.open()
      end
    end,
  })
end

-- antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

-- nvim-treesitter/nvim-treesitter-context
require('treesitter-context').setup({
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 3,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
  multiwindow = true,
})

-- windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- kevinhwang91/nvim-ufo
--
-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
local function handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('ufo').setup({
  fold_virt_text_handler = handler,
  provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end,
  -- To fix missing required fields:
  -- open_fold_hl_timeout = 400,
  -- close_fold_kinds_for_ft = { default = {} },
  -- enable_get_fold_virt_text = false,
  -- preview = {
  --   win_config = {
  --     border = 'rounded',
  --     winblend = 12,
  --     winhighlight = 'Normal:Normal',
  --     maxheight = 20,
  --   },
  --   mappings = {},
  -- },
})
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })

-- stevearc/quicker.nvim
require('quicker').setup({
  borders = {
    -- Thinner separator.
    vert = require('icons').misc.vertical_bar,
  },
})
vim.keymap.set(
  'n',
  '<leader>tl',
  function() require('quicker').toggle({ loclist = true }) end,
  { desc = 'Toggle loclist' }
)
vim.keymap.set(
  'n',
  '<leader>tq',
  require('quicker').toggle,
  { desc = 'Toggle quickfix' }
)

-- DanWlker/snacks.nvim
local function list_extend(where, what)
  return vim.list_extend(vim.deepcopy(where), what)
end
local function list_filter(where, what)
  return vim
    .iter(where)
    :filter(function(val) return not vim.list_contains(what, val) end)
    :totable()
end
vim.api.nvim_create_user_command(
  'ScratchToggle',
  function() require('snacks').scratch() end,
  { desc = 'Scratch Toggle Buffer' }
)
vim.api.nvim_create_user_command(
  'ScratchSelect',
  function() require('snacks').scratch.select() end,
  { desc = 'Scratch Select Buffer' }
)
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
      preview = {
        wo = {
          wrap = true,
        },
      },
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
          if opts.case_sens then opts.args = list_extend(opts.args, args_extend) end
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
        actions = {
          accept = function(picker, item)
            picker:close()
            vim.cmd(item.cmd)
          end,
        },
        win = {
          input = {
            keys = {
              ['<cr>'] = { 'accept', mode = { 'i', 'n' } }, -- Execute
              ['<tab>'] = { 'confirm', mode = { 'i', 'n' } }, -- Choose
            },
          },
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
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    local should_flatten = {
      ['json'] = true,
      ['yaml'] = true,
      ['toml'] = true,
      ['helm'] = true,
    }

    map(
      'grr',
      function() Snacks.picker.lsp_references() end,
      'Snacks.picker.lsp_references()'
    )
    map(
      'gri',
      function() Snacks.picker.lsp_implementations() end,
      'Snacks.picker.lsp_implementations()'
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
    end, 'Snacks.picker.lsp_symbols()')
    map(
      'grc',
      function() Snacks.picker.lsp_incoming_calls() end,
      'Snacks.picker.lsp_incoming_calls()'
    )
    map(
      'gro',
      function() Snacks.picker.lsp_outgoing_calls() end,
      'Snacks.picker.lsp_outgoing_calls()'
    )
    map(
      'gd',
      function() Snacks.picker.lsp_definitions() end,
      'Snacks.picker.lsp_definitions()'
    )
    map(
      'grt',
      function() Snacks.picker.lsp_type_definitions() end,
      'Snacks.picker.lsp_type_definitions()'
    )
    map(
      'gW',
      function() Snacks.picker.lsp_workspace_symbols() end,
      'Snacks.picker.lsp_workspace_symbols()'
    )
  end,
})
-- vim.keymap.set(
--   'n',
--   '\\',
--   function()
--     Snacks.explorer()
--   end,
--   { desc = 'Explorer Snacks (cwd)' }
-- )
vim.keymap.set(
  'n',
  '<leader>fn',
  function() Snacks.picker.notifications() end,
  { desc = 'Find Notification History' }
)
vim.keymap.set(
  'n',
  '<leader>fh',
  function() Snacks.picker.help() end,
  { desc = 'Find Help' }
)
vim.keymap.set(
  'n',
  '<leader>fk',
  function() Snacks.picker.keymaps() end,
  { desc = 'Find Keymaps' }
)
vim.keymap.set(
  'n',
  '<leader>ff',
  function() Snacks.picker.files() end,
  { desc = 'Find Files' }
)
vim.keymap.set(
  'n',
  '<leader>fm',
  function() Snacks.picker.pickers() end,
  { desc = 'Find More Picker Uses' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<leader>fw',
  function() Snacks.picker.grep_word() end,
  { desc = 'Find Word' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<leader>fc',
  function() Snacks.picker.commands() end,
  { desc = 'Find Commands' }
)
vim.keymap.set(
  'n',
  '<leader>fg',
  function() Snacks.picker.grep() end,
  { desc = 'Find with Grep' }
)
vim.keymap.set(
  'n',
  '<leader>fd',
  function() Snacks.picker.diagnostics() end,
  { desc = 'Find Diagnostics' }
)
vim.keymap.set(
  'n',
  '<leader>fa',
  function() Snacks.picker.resume() end,
  { desc = 'Find Again' }
)
vim.keymap.set(
  'n',
  '<leader>f.',
  function() Snacks.picker.recent() end,
  { desc = 'Find Recent Files' }
)
vim.keymap.set(
  'n',
  '<leader><leader>',
  function() Snacks.picker.buffers() end,
  { desc = 'Find Existing Buffers' }
)
vim.keymap.set(
  'n',
  '<leader>f/',
  function() Snacks.picker.lines() end,
  { desc = 'Find Fuzzily in Current Buffer' }
)
vim.keymap.set(
  'n',
  '<leader>fo',
  function() Snacks.picker.grep_buffers() end,
  { desc = 'Find in Open Files' }
)
vim.keymap.set(
  'n',
  '<leader>fN',
  function()
    Snacks.picker.files({
      cwd = vim.fn.stdpath('config'),
    })
  end,
  { desc = 'Find Neovim Files' }
)
vim.keymap.set(
  'n',
  '<leader>f:',
  function() Snacks.picker.command_history() end,
  { desc = 'Find Command History' }
)
vim.keymap.set(
  'n',
  '<leader>fj',
  function() Snacks.picker.jumps() end,
  { desc = 'Find Jumps' }
)
vim.keymap.set(
  'n',
  '<leader>fu',
  function() Snacks.picker.undo() end,
  { desc = 'Find Undo History' }
)
vim.keymap.set(
  'n',
  '<leader>fC',
  function() Snacks.picker.colorschemes() end,
  { desc = 'Find Colorschemes' }
)
vim.keymap.set(
  'n',
  '<leader>fH',
  function() Snacks.picker.highlights() end,
  { desc = 'Find Highlights' }
)
vim.keymap.set(
  'n',
  '<leader>f"',
  function() Snacks.picker.registers() end,
  { desc = 'Find Registers' }
)
vim.keymap.set('n', '<leader>ft', function()
  if not package.loaded['todo-comments'] then require('todo-comments') end
  Snacks.picker.todo_comments()
end, { desc = 'Find Todo' })
vim.keymap.set('n', '<leader>fT', function()
  if not package.loaded['todo-comments'] then require('todo-comments') end
  Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
end, { desc = 'Find Todo/Fix/Fixme' })
vim.keymap.set(
  'n',
  '<leader>ts',
  function() Snacks.scratch() end,
  { desc = 'Toggle scratch buffer' }
)

-- todo-comments
require('todo-comments').setup({ signs = false })

-- folke/trouble.nvim
require('trouble').setup()
vim.keymap.set(
  'n',
  '<leader>xd',
  '<cmd>Trouble diagnostics toggle<cr>',
  { desc = 'Diagnostics' }
)
vim.keymap.set(
  'n',
  '<leader>xD',
  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'Buffer Diagnostics' }
)
vim.keymap.set(
  'n',
  '<leader>xs',
  '<cmd>Trouble symbols toggle focus=false win.size=0.4<cr>',
  { desc = 'Symbols' }
)
vim.keymap.set(
  'n',
  '<leader>xl',
  '<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.4<cr>',
  { desc = 'LSP Definitions / references / ...' }
)
vim.keymap.set(
  'n',
  '<leader>xL',
  '<cmd>Trouble loclist toggle<cr>',
  { desc = 'Location List' }
)
vim.keymap.set(
  'n',
  '<leader>xQ',
  '<cmd>Trouble qflist toggle<cr>',
  { desc = 'Quickfix List' }
)
vim.keymap.set('n', '<C-p>', function()
  if require('trouble').is_open() then
    require('trouble').prev({ skip_groups = true, jump = true })
  end
end, { desc = 'Previous Trouble/Quickfix Item' })
vim.keymap.set('n', '<C-n>', function()
  if require('trouble').is_open() then
    require('trouble').next({ skip_groups = true, jump = true })
  end
end, { desc = 'Next Trouble/Quickfix Item' })
vim.keymap.set('n', '<leader>xc', function()
  if require('trouble').is_open() then require('trouble').close() end
end, { desc = 'Close' })
vim.keymap.set(
  'n',
  '<leader>xt',
  '<cmd>TodoTrouble toggle<cr>',
  { desc = 'Todo List' }
)

-- kristijanhusak/vim-dadbod-ui
vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font
vim.g.db_ui_use_nvim_notify = 1
vim.api.nvim_create_user_command('DBUITab', function()
  vim.cmd('tabnew')
  vim.cmd('DBUI')
  vim.cmd('set shiftwidth=2')
end, {
  desc = 'Open DBUI in another tab',
})

-- mcauley-penney/visual-whitespace.nvim
require('visual-whitespace').setup({
  --   nl_char = '󰌑',
  ignore = {
    buftypes = {
      'nofile',
      'help',
      'quickfix',
    },
  },
})
vim.keymap.set(
  'n',
  '<leader>tv',
  function() require('visual-whitespace').toggle() end,
  { desc = 'Toggle visual-whitespace' }
)

-- folke/which-key.nvim
require('which-key').setup({
  preset = 'helix',
  delay = 500,
  keys = {
    scroll_down = '',
    scroll_up = '',
  },
  icons = {
    -- mappings = vim.g.have_nerd_font,
    mappings = false,
  },

  spec = {
    { '<leader>x', group = 'Trouble' },
    { '<leader>f', group = '[F]ind', mode = { 'n', 'x' } },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>g', group = '[G]it' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>a', group = '[A]i' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
  triggers = {
    { '<auto>', mode = 'nixsotc' },
    { 'j', mode = { 'n' } }, -- for mini.splitjoin
  },
})
