-- Installation Hooks has to be before vim.pack
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
      return
    end

    if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
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
  'https://github.com/DanWlker/nvim-jump',
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
  'https://github.com/dlyongemallo/diffview.nvim',
  'https://github.com/f-person/git-blame.nvim',
  'https://github.com/rhysd/git-messenger.vim',
  'https://github.com/nvim-mini/mini.diff',
  'https://github.com/nvim-mini/mini-git',
  -- lang
  'https://github.com/b0o/SchemaStore.nvim',
  -- FIX: Having issues with tsgo, awaiting upstream merge:
  -- https://github.com/dmmulroy/ts-error-translator.nvim/pull/44
  -- 'https://github.com/dmmulroy/ts-error-translator.nvim',
  'https://github.com/DanWlker/ts-error-translator.nvim',
  -- plugins
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
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  {
    src = 'https://github.com/DanWlker/nvim-lint',
    version = 'droast',
  },
  'https://github.com/antosha417/nvim-lsp-file-operations',
  'https://github.com/DanWlker/nvim-tree.lua',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/stevearc/quicker.nvim',
  {
    src = 'https://github.com/DanWlker/snacks.nvim',
    version = 'keep_parents_ordering',
  },
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/mcauley-penney/visual-whitespace.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/nemanjamalesija/smart-paste.nvim',
  'https://github.com/mistweaverco/kulala.nvim',
})

-- catppuccin/nvim
require('catppuccin').setup({
  auto_integrations = false, -- Disables the slow 212ms detection
  integrations = {
    blink_cmp = {
      enabled = true,
      style = 'bordered',
    },
    dadbod_ui = true,
    dap = true,
    diffview = true,
    flash = true,
    lsp_trouble = true,
    mason = true,
    mini = {
      enabled = true,
      indentscope_color = 'overlay2',
    },
    nvimtree = true,
    snacks = {
      enabled = true,
    },
    treesitter_context = true,
    ufo = true,
    which_key = true,
    lsp_styles = {
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
  float = {
    transparent = true,
  },
  custom_highlights = function(colors)
    local U = require('catppuccin.utils.colors')
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
      -- VSCode-style side-by-side diff: red = old/left, green = new/right.
      -- Consumed by the diff_buf_win_enter hook in diffview.setup() below.
      -- `DiffAdd` (green changed line, new side) is already defined by
      -- catppuccin, so only the three missing groups are added here. Line
      -- backgrounds use the 0.18 blend catppuccin uses for DiffAdd/DiffDelete;
      -- the changed-char groups use a stronger 0.30 blend so edits pop.
      DiffAddAsDelete = { bg = U.darken(colors.red, 0.18, colors.base) },
      DiffDeleteText = { bg = U.darken(colors.red, 0.30, colors.base) },
      DiffTextAdd = { bg = U.darken(colors.green, 0.30, colors.base) },

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
      TabLinePillLabelLeft = { fg = colors.surface1 },
      TabLinePillLabelText = { bg = colors.surface1, fg = colors.subtext1 },
      TabLinePillLabelRight = { fg = colors.surface1 },

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
local palette = require('catppuccin.palettes').get_palette()
vim.cmd.colorscheme('catppuccin')

-- folke/which-key.nvim
local which_key = require('which-key')
which_key.setup({
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
    { '<leader>g', group = '[G]it' },
    { '<leader>t', group = '[T]oggle' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
  triggers = {
    { '<auto>', mode = 'nixsotc' },
    { 'j', mode = { 'n' } }, -- for mini.splitjoin
  },
})

-- nvim-mini/mini.icons
local ext3_blocklist = { scm = true, txt = true, yml = true }
local ext4_blocklist = { json = true, yaml = true }
local mini_icons = require('mini.icons')
mini_icons.setup({
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
local dial_map = require('dial.map')
vim.keymap.set(
  'n',
  '<C-a>',
  function() dial_map.manipulate('increment', 'normal') end
)
vim.keymap.set(
  'n',
  '<C-x>',
  function() dial_map.manipulate('decrement', 'normal') end
)
vim.keymap.set(
  'n',
  'g<C-a>',
  function() dial_map.manipulate('increment', 'gnormal') end
)
vim.keymap.set(
  'n',
  'g<C-x>',
  function() dial_map.manipulate('decrement', 'gnormal') end
)
vim.keymap.set(
  'x',
  '<C-a>',
  function() dial_map.manipulate('increment', 'visual') end
)
vim.keymap.set(
  'x',
  '<C-x>',
  function() dial_map.manipulate('decrement', 'visual') end
)
vim.keymap.set(
  'x',
  'g<C-a>',
  function() dial_map.manipulate('increment', 'gvisual') end
)
vim.keymap.set(
  'x',
  'g<C-x>',
  function() dial_map.manipulate('decrement', 'gvisual') end
)

-- yorickpeterse/nvim-jump
local jump = require('jump')
jump.setup({
  labels = 'shtarenigpcydolubvjwfzkxqmSHTARENIGPCYDOLUBVJWFZKXQM',
})
vim.keymap.set(
  { 'n', 'x', 'o' },
  'h',
  jump.start,
  { desc = 'Hop (On the character)' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  'H',
  function() jump.start({ before = true }) end,
  { desc = 'Hop (Before the character)' }
)

-- NMAC427/guess-indent.nvim
require('guess-indent').setup()

-- nvim-mini/mini.extra
local miniextra = require('mini.extra')
miniextra.setup()

-- nvim-mini/mini.ai
-- TODO: remove after nvim 0.13 as this provides the same functionality
-- https://github.com/neovim/neovim/pull/39845
-- could change: https://github.com/neovim/neovim/issues/39893
local function nvim_013_l_textobject()
  return function(ai_type, _, opts)
    -- taken from miniextra.gen_ai_spec.line(),
    if ai_type == 'i' then
      local lnum_from = vim.fn.line('.')
      local lnum_to = lnum_from + opts.n_times - 1
      local line_from, line_to = vim.fn.getline(lnum_from), vim.fn.getline(lnum_to)
      -- Ignore indentation for `i` textobject
      local col_from = line_from:match('^(%s*)'):len() + 1
      -- Don't select `\n` past the line to operate within a line
      local col_to = line_to:len()

      return {
        from = { line = lnum_from, col = col_from },
        to = { line = lnum_to, col = col_to },
      }
    end

    -- taken from miniextra.gen_ai_spec.buffer()
    local start_line, end_line = 1, vim.fn.line('$')
    local to_col = math.max(vim.fn.getline(end_line):len(), 1)
    return {
      from = { line = start_line, col = 1 },
      to = { line = end_line, col = to_col },
    }
  end
end
local ai = require('mini.ai')
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
    u = ai.gen_spec.function_call(), -- u for "Usage"
    U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
    l = nvim_013_l_textobject(),
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

  which_key.add(ret, { notify = false })
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
-- NOTE: the hooks go through setup() so they apply globally. Setting
-- vim.b.minisplitjoin_config here would only ever reach the empty startup
-- buffer, which nvim discards as soon as a file is opened.
local mini_splitjoin = require('mini.splitjoin')
local gen_hook = mini_splitjoin.gen_hook
mini_splitjoin.setup({
  mappings = {
    toggle = 'jT',
    split = 'jS',
    join = 'jJ',
  },
  split = {
    hooks_post = { gen_hook.add_trailing_separator() },
  },
  join = {
    hooks_post = { gen_hook.del_trailing_separator() },
  },
})

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
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  group = vim.api.nvim_create_augroup(
    'danwlker/nvim-treesitter-parser',
    { clear = true }
  ),
  callback = function()
    local parsers = require('nvim-treesitter.parsers')
    parsers.go_tags = {
      install_info = {
        url = 'https://github.com/DanWlker/tree-sitter-go_tags',
        queries = 'queries',
      },
    }
    parsers.tmux = {
      install_info = {
        url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
        generate = true,
        generate_from_json = false,
        queries = 'queries',
      },
    }
  end,
})
---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)

  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
local nvim_treesitter = require('nvim-treesitter')
local available_parsers = nvim_treesitter.get_available()
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

    local installed_parsers = nvim_treesitter.get_installed('parsers')
    if vim.tbl_contains(installed_parsers, language) then
      -- enable the parser if it is installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
      nvim_treesitter
        .install(language)
        :await(function() treesitter_try_attach(buf, language) end)
    else
      -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})
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
  'terraform',
  'hcl',
  'tmux',
})

-- nvim-treesitter-textobjects
require('nvim-treesitter-textobjects').setup()

-- gbprod/substitute.nvim
local substitute = require('substitute')
local substitute_exchange = require('substitute.exchange')
substitute.setup({
  -- yank_substituted_text = true,
  highlight_substituted_text = {
    timer = 150,
  },
})
vim.keymap.set('n', 's', substitute.operator, { desc = 'Substitute' })
vim.keymap.set('x', 's', substitute.visual, { desc = 'Substitute' })
vim.keymap.set({ 'n', 'x' }, 'S', substitute.eol, { desc = 'Substitute to eol' })
vim.keymap.set('n', 'ss', substitute.line, { desc = 'Substitute line' })
vim.keymap.set(
  'n',
  'gs',
  substitute_exchange.operator,
  { desc = 'Substitute exchange' }
)
vim.keymap.set(
  'x',
  'gs',
  substitute_exchange.visual,
  { desc = 'Substitute exchange' }
)
vim.keymap.set(
  'n',
  'gss',
  substitute_exchange.line,
  { desc = 'Substitute exchange line' }
)

-- Wansmer/treesj
local treesj = require('treesj')
treesj.setup({ use_default_keymaps = false })
vim.keymap.set('n', 'jt', treesj.toggle)
vim.keymap.set('n', 'js', treesj.split)
vim.keymap.set('n', 'jj', treesj.join)

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
require('blame').setup({ blame_options = { '-w' } })
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
  -- https://github.com/sindrets/diffview.nvim/issues/241
  -- https://github.com/sindrets/diffview.nvim/pull/258#issuecomment-1408689220
  hooks = {
    diff_buf_win_enter = function(_, _, ctx)
      if ctx.layout_name:match('^diff2') then
        if ctx.symbol == 'a' then
          vim.opt_local.winhl = table.concat({
            'DiffChange:DiffAddAsDelete',
            'DiffText:DiffDeleteText',
          }, ',')
        elseif ctx.symbol == 'b' then
          vim.opt_local.winhl = table.concat({
            'DiffChange:DiffAdd',
            'DiffText:DiffTextAdd',
          }, ',')
        end
      end
    end,
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
require('gitblame').setup({ enabled = false })
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
local mini_diff = require('mini.diff')
mini_diff.setup({
  view = { style = 'sign', signs = { add = '▎', change = '▎', delete = '' } },
})
vim.keymap.set(
  'n',
  '<leader>gd',
  function() mini_diff.toggle_overlay(0) end,
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
    'tsgo',
  },
})

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
      auto_brackets = { enabled = false },
    },
    menu = {
      border = 'rounded',
      draw = {
        -- treesitter = { 'lsp' },
        -- align_to = 'cursor',
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = mini_icons.get('lsp', ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = mini_icons.get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = mini_icons.get('lsp', ctx.kind)
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

-- mistweaverco/kulala.nvim
require('kulala').setup({
  -- your configuration comes here
  global_keymaps = true,
  global_keymaps_prefix = '<leader>r',
  kulala_keymaps_prefix = '',
  ui = {
    split_direction = 'horizontal',
  },
})

-- stevearc/conform.nvim
local oxfmt = { 'oxfmt' }
-- local disable_filetypes = {}
local prefer_lsp = {}
local fallback_to_lsp = { -- only fallback to lsp if no formatter
  lua = true,
  html = true, -- superhtml lsp has issues formatting <script> tags
  -- tsgo formats typescript weirdly for some reason
  typescript = true,
  typescriptreact = true,
}
vim.keymap.set(
  'n',
  '<leader>tf',
  function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  { desc = 'Toggle format' }
)
local conform = require('conform')
local sqruff_util = require('sqruff')
vim.api.nvim_create_user_command(
  'ConformFormat',
  function() conform.format({ async = true }) end,
  { desc = 'Format buffer' }
)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
conform.setup({
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
      -- should be safe to put this as default, most people and projects have lsp
      -- and lsp is usually the priority? I think
      -- NOTE: last here means lsp format will run last, unlike fallback which doesn't run lsp format if a formatter is available
      to_return['lsp_format'] = 'last'
    end

    -- Why not use 'fallback' as a default?
    -- Gopls should be prioritised
    -- And usually LSP is done by the language designers? so.. in that case
    -- if they provide a formatter, we should use it.
    -- 'first' also not suitable for the same reason
    -- 'prefer' is different from not specfiying because not specfiying means uting trim_whitespace and trim_newlines
    -- 'never' is in cases like maybe javascript? where we only want to use prettier but in this case i think 'last' works as well

    return to_return
  end,
  formatters = {
    sqruff = {
      args = function(_, ctx)
        return { 'fix', sqruff_util.dialect_arg(ctx.buf), '$FILENAME' }
      end,
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
    -- biome = { require_cwd = true },
  },
  formatters_by_ft = {
    c = { 'clang-format' },
    -- go = { 'goimports' }, -- 'gofumpt' is lsp handled, slows down gopls if configured here
    javascript = oxfmt,
    javascriptreact = oxfmt,
    json = oxfmt,
    jsonc = oxfmt,
    lua = { 'stylua' },
    markdown = oxfmt, -- markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
    css = oxfmt,
    scss = oxfmt,
    sql = { 'sqruff' },
    typescript = oxfmt,
    typescriptreact = oxfmt,
    yaml = oxfmt,
    python = {
      -- To fix auto-fixable lint errors.
      'ruff_fix',
      -- To run the Ruff formatter.
      'ruff_format',
      -- To organize the imports.
      'ruff_organize_imports',
    },
    graphql = oxfmt,
    html = oxfmt,
    vue = oxfmt,
    rust = { 'rustfmt' },
    ['_'] = { 'trim_whitespace', 'trim_newlines' },
    hcl = { 'packer_fmt' },
    terraform = { 'terraform_fmt' },
    tf = { 'terraform_fmt' },
    ['terraform-vars'] = { 'terraform_fmt' },
    zsh = { 'shfmt' },
    http = { 'kulala-fmt' },
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
    -- Sourced from the palette so they can't drift from the theme
    style = {
      palette.overlay2,
      palette.maroon,
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
require('luasnip.loaders.from_lua').lazy_load({
  paths = vim.fn.stdpath('config') .. '/snippets',
})

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
require('mason-lspconfig').setup({ automatic_enable = false })

-- jay-babu/mason-nvim-dap.nvim
local dap = require('dap')
local mason_nvim_dap = require('mason-nvim-dap')
mason_nvim_dap.setup({
  handlers = {
    function(config) mason_nvim_dap.default_setup(config) end,
    delve = function(config)
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      config.adapters.executable.detached = vim.fn.has('win32') == 0

      -- Attach to an already-running headless delve, e.g.
      -- dlv debug -l 127.0.0.1:38697 --headless main.go
      -- https://github.com/golang/vscode-go/wiki/debugging#launchjson-attributes
      -- https://stackoverflow.com/a/70661460
      dap.adapters.delve_remote = {
        type = 'server',
        host = '127.0.0.1',
        port = 38697,
      }
      table.insert(config.configurations, {
        type = 'delve_remote',
        name = 'Delve: Attach (127.0.0.1:38697)',
        mode = 'remote',
        request = 'attach',
      })

      mason_nvim_dap.default_setup(config)
    end,
  },
})

-- WhoIsSethDaniel/mason-tool-installer.nvim
require('mason-tool-installer').setup({
  ensure_installed = {
    'ty',
    'tombi',
    'helm_ls',
    'marksman',
    'yamlls',
    'jsonls',
    'dockerls',
    'docker_compose_language_service',
    'clangd',
    'gopls', -- Check your go env version, cauld cause issues
    'superhtml',
    'cssls',
    'tsc',
    'emmet_language_server',
    'lua_ls',
    'tailwindcss',
    'bashls',
    'bacon_ls',
    'terraformls',
    'oxfmt',
    'oxlint',

    -- tools
    'stylua',
    'markdownlint-cli2',
    -- 'markdown-toc',
    'golangci-lint', -- Check your go env version, cauld cause issues
    'clang-format',
    'yamllint',
    'gofumpt', -- Check your go env version, cauld cause issues
    'hadolint',
    'sqruff',
    'delve',
    'shellcheck', --used by bashls
    'shfmt', --used by bashls
    -- 'goimports',
    -- 'tree-sitter-cli', -- don't use this, use brew installed one
    'ruff',
    -- 'yamlfmt',
    'bacon', -- used by bacon_ls
    -- 'rustfmt', -- deprecated, install this using rustup
    'tflint',
    'kulala-fmt',
  },
})

-- nvim-mini/mini.hipatterns
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
        if match == '#add' then return end
        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
        local hex_color = '#' .. r .. r .. g .. g .. b .. b

        return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
      end,
      extmark_opts = { priority = 2000 },
    },
  },
})

-- nacro90/numb.nvim
require('numb').setup()

-- kevinhwang91/nvim-bqf
require('bqf').setup()

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
require('nvim-dap-virtual-text').setup({ virt_text_pos = 'eol' })

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
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set(
  'n',
  '<leader>b',
  dap.toggle_breakpoint,
  { desc = 'Debug: Toggle Breakpoint' }
)
vim.keymap.set(
  'n',
  '<leader>B',
  function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
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

-- sqruff
local sqruff = lint.linters.sqruff
lint.linters.sqruff = function()
  local linter = vim.deepcopy(sqruff)
  linter.args = { 'lint', '--format=json', sqruff_util.dialect_arg(0), '-' }
  return linter
end

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
  dockerfile = { 'hadolint', 'droast' },
  sql = { 'sqruff' },
  python = { 'ruff' },
  terraform = { 'terraform_validate' },
  tf = { 'terraform_validate' },
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
  if vim.bo.filetype == 'NvimTree' then
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
        local screen_w = vim.o.columns
        local screen_h = vim.o.lines - vim.o.cmdheight
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.o.lines - window_h) / 2) - vim.o.cmdheight
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
    width = function() return math.floor(vim.o.columns * WIDTH_RATIO) end,
  }
end
require('nvim-tree').setup({
  on_attach = function(bufnr)
    -- { lhs, api function, description }
    for _, m in ipairs({
      { 'K', tree_api.node.show_info_popup, 'Info' },
      { '<C-t>', tree_api.node.open.tab, 'Open: New Tab' },
      { '<C-v>', tree_api.node.open.vertical, 'Open: Vertical Split' },
      { '<C-s>', tree_api.node.open.horizontal, 'Open: Horizontal Split' },
      { '<BS>', tree_api.node.navigate.parent_close, 'Close Directory' },
      { '<CR>', tree_api.node.open.edit, 'Open' },
      { '.', tree_api.node.run.cmd, 'Run Command' },
      { 'a', tree_api.fs.create, 'Create File Or Directory' },
      { 'bd', tree_api.marks.bulk.delete, 'Delete Bookmarked' },
      { 'bD', tree_api.marks.bulk.trash, 'Trash Bookmarked' },
      { 'bmv', tree_api.marks.bulk.move, 'Move Bookmarked' },
      { 'B', tree_api.filter.no_buffer.toggle, 'Toggle Filter: No Buffer' },
      { 'y', tree_api.fs.copy.node, 'Copy' },
      { 'd', tree_api.fs.remove, 'Delete' },
      { 'D', tree_api.fs.trash, 'Trash' },
      { 'E', tree_api.tree.expand_all, 'Expand All' },
      { 'F', tree_api.filter.live.clear, 'Live Filter: Clear' },
      { 'f', tree_api.filter.live.start, 'Live Filter: Start' },
      { 'g?', tree_api.tree.toggle_help, 'Help' },
      { 'H', tree_api.filter.dotfiles.toggle, 'Toggle Filter: Dotfiles' },
      { 'I', tree_api.filter.git.ignored.toggle, 'Toggle Filter: Git Ignore' },
      { 'M', tree_api.filter.no_bookmark.toggle, 'Toggle Filter: No Bookmark' },
      { 'm', tree_api.marks.toggle, 'Toggle Bookmark' },
      { 'p', tree_api.fs.paste, 'Paste' },
      { 'P', tree_api.node.navigate.parent, 'Parent Directory' },
      { 'q', tree_api.tree.close, 'Close' },
      { 'r', tree_api.fs.rename_full, 'Rename' },
      { 'R', tree_api.tree.reload, 'Refresh' },
      { 'W', tree_api.tree.collapse_all, 'Collapse' },
      { 'x', tree_api.fs.cut, 'Cut' },
      { 'gc', tree_api.fs.copy.filename, 'Copy Name' },
      { 'c', tree_api.fs.copy.relative_path, 'Copy Relative Path' },
      { 'C', tree_api.fs.copy.absolute_path, 'Copy Absolute Path' },
    }) do
      vim.keymap.set('n', m[1], m[2], {
        desc = 'nvim-tree: ' .. m[3],
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      })
    end
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
    open_file = {
      window_picker = {
        picker = function()
          local open_file = require('nvim-tree.actions.node.open-file')
          tree_api.tree.close()
          local winid = open_file.pick_win_id()
          tree_api.tree.open()
          return winid
        end,
      },
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
local ufo = require('ufo')
ufo.setup({
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
vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })

-- stevearc/quicker.nvim
local quicker = require('quicker')
quicker.setup({
  borders = {
    -- Thinner separator.
    vert = require('icons').misc.vertical_bar,
  },
})
vim.keymap.set(
  'n',
  '<leader>xl',
  function() quicker.toggle({ loclist = true }) end,
  { desc = 'Toggle loclist' }
)
vim.keymap.set('n', '<leader>xq', quicker.toggle, { desc = 'Toggle quickfix' })

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
local ivy_no_preview = {
  hidden = { 'preview' },
  preset = 'ivy',
}
local ivy_preview = {
  preset = 'ivy',
}
local files_config = {
  hidden = true,
  ignored = true,
  exclude = { -- keep this ignored even if toggling to show hidden/ignored
    'node_modules',
    '.DS_Store',
    '*.docx',
    '*.zip',
    '*.pptx',
  },
  matcher = { frecency = true },
  layout = ivy_no_preview,
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
  statuscolumn = { enabled = true },
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
    layouts = {
      ivy = { layout = { backdrop = true } },
    },
    -- Default for every source; only the no-preview ones override below.
    layout = ivy_preview,
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
        layout = ivy_no_preview,
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
      pickers = { layout = ivy_no_preview },
      highlights = { layout = ivy_no_preview },
      grep_buffers = { layout = ivy_no_preview },
      colorschemes = { -- fix colorscheme wont change if preview is not enabled
        layout = ivy_no_preview,
        confirm = function(picker, item)
          picker.opts._confirmed = true
          picker:close()
          if item then
            vim.schedule(function() vim.cmd('colorscheme ' .. item.text) end)
          end
        end,
        on_show = function(picker)
          picker.opts._orig =
            { cs = vim.g.colors_name or 'default', bg = vim.o.background }
        end,
        on_change = function(_, item)
          if item then
            vim.schedule(function() vim.cmd('colorscheme ' .. item.text) end)
          end
        end,
        on_close = function(picker)
          local orig = picker.opts._orig
          if orig and not picker.opts._confirmed then
            vim.schedule(function()
              vim.cmd('colorscheme ' .. orig.cs)
              vim.o.background = orig.bg
            end)
          end
        end,
      },
      notifications = { layout = ivy_no_preview },
      lines = { layout = ivy_no_preview },
      command_history = { layout = ivy_no_preview },
      lsp_symbols = {
        filter = {
          default = true,
          lua = true,
        },
        keep_parents = true,
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
vim.api.nvim_create_user_command(
  'ScratchToggle',
  function() Snacks.scratch() end,
  { desc = 'Scratch Toggle Buffer' }
)
vim.api.nvim_create_user_command(
  'ScratchSelect',
  function() Snacks.scratch.select() end,
  { desc = 'Scratch Select Buffer' }
)
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
    map(
      'gO',
      function() Snacks.picker.lsp_symbols() end,
      'Snacks.picker.lsp_symbols()'
    )
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
vim.keymap.set(
  'n',
  '<leader>ft',
  function()
    Snacks.picker.todo_comments({
      layout = ivy_preview,
    })
  end,
  { desc = 'Find Todo' }
)
vim.keymap.set(
  'n',
  '<leader>fT',
  function()
    Snacks.picker.todo_comments({
      keywords = { 'TODO', 'FIX', 'FIXME' },
      layout = ivy_preview,
    })
  end,
  { desc = 'Find Todo/Fix/Fixme' }
)
vim.keymap.set(
  'n',
  '<leader>ts',
  function() Snacks.scratch() end,
  { desc = 'Toggle scratch buffer' }
)

-- todo-comments
require('todo-comments').setup({ signs = false })

-- folke/trouble.nvim
local trouble = require('trouble')
trouble.setup()
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
  '<leader>xr',
  '<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.4<cr>',
  { desc = 'LSP Definitions / references / ...' }
)
vim.keymap.set(
  'n',
  '<leader>xL',
  '<cmd>Trouble loclist toggle<cr>',
  { desc = 'Open Location List in Trouble' }
)
vim.keymap.set(
  'n',
  '<leader>xQ',
  '<cmd>Trouble qflist toggle<cr>',
  { desc = 'Open Quickfix List in Trouble' }
)
vim.keymap.set('n', '<C-p>', function()
  if trouble.is_open() then trouble.prev({ skip_groups = true, jump = true }) end
end, { desc = 'Previous Trouble/Quickfix Item' })
vim.keymap.set('n', '<C-n>', function()
  if trouble.is_open() then trouble.next({ skip_groups = true, jump = true }) end
end, { desc = 'Next Trouble/Quickfix Item' })
vim.keymap.set('n', '<leader>xc', function()
  if trouble.is_open() then trouble.close() end
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
  vim.cmd('setlocal shiftwidth=2')
end, {
  desc = 'Open DBUI in another tab',
})

-- nemanjamalesija/smart-paste.nvim
require('smart-paste').setup()

-- mcauley-penney/visual-whitespace.nvim
local visual_whitespace = require('visual-whitespace')
visual_whitespace.setup({
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
  function() visual_whitespace.toggle() end,
  { desc = 'Toggle visual-whitespace' }
)

-- vim.defer_fn(function()
--   local ok, detect = pcall(require, 'catppuccin.lib.detect_integrations')
--   if ok then
--     local detected_plugins = detect.detect_plugins()
--     print('=== DETECTED PLUGINS ===')
--     print(vim.inspect(detected_plugins))
--
--     local integration_table = detect.create_integrations_table()
--     print('=== AUTO-ENABLED INTEGRATIONS ===')
--     print(vim.inspect(integration_table))
--   end
-- end, 1000) -- Run after startup
