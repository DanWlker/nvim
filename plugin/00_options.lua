-- Enable faster startup by caching compiled lua modules
vim.loader.enable()

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true
g.loaded_netrw = 1 -- disable netrw (copied from nvim-tree)
g.loaded_netrwPlugin = 1 -- disable netrw (copied from nvim-tree)

local o = vim.o

-- UI options
o.number = true
o.relativenumber = true
o.signcolumn = 'yes' -- Always show sign column
o.mouse = 'a' -- Enable mouse support in all modes
vim.schedule(function() o.clipboard = 'unnamedplus' end) -- Use system clipboard (after startup)
o.cursorline = true -- Highlight current line
o.cursorlineopt = 'number' -- Only highlight line number

-- Indentation & formatting
o.smartindent = true -- Auto-indent new lines smartly
o.shiftwidth = 2 -- Shift size for << and >>
o.shiftround = true -- Round indent to multiples of shiftwidth
o.breakindent = true -- Maintain indent when wrapping
o.breakindentopt = 'list:-1' -- Additional breakindent settings
o.linebreak = true -- Break lines at word boundaries
o.formatoptions = 'rqnl1j' -- Formatting behavior https://neovim.io/doc/user/change.html#fo-table
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]] -- Recognize list patterns

-- Search
o.ignorecase = true -- Case-insensitive search...
o.smartcase = true -- ...unless uppercase in pattern
o.inccommand = 'split' -- Live preview substitute changes

-- Backup/undo
o.undofile = true -- Persistent undo across sessions
o.swapfile = false -- Disable swapfiles
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file size for faster startup

-- Performance
o.updatetime = 250 -- CursorHold delay
o.timeoutlen = 500 -- Mapped sequence wait time
o.lazyredraw = true -- Don’t redraw while executing macros

-- Window management
o.splitright = true -- New splits open to the right
o.splitbelow = true -- New splits open below
o.laststatus = 3 -- Global statusline
o.scrolloff = 12 -- Keep 12 lines visible above/below cursor
o.sidescrolloff = 12 -- Same but horizontally
-- o.splitkeep = 'screen' -- Keeps text o same screen line

-- Display and wrapping
o.wrap = false -- Disable line wrap
o.list = false -- Don't show invisible chars by default
o.termguicolors = true -- True color support

-- Completion
o.complete = '.,w,b,kspell' -- Completion sources
o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Popup menu behavior
o.pumborder = 'rounded' -- Built-in completion window
o.pumheight = 10 -- Max height of completion popup

-- Misc behavior
o.confirm = true -- Confirm instead of erroring on quit
o.grepformat = '%f:%l:%c:%m' -- Format for grep outputs
o.grepprg = 'rg --vimgrep' -- Use ripgrep for :grep
o.jumpoptions = 'stack' -- Make jumplist more intuitive
o.infercase = true -- Smarter case detection when completing
o.foldmethod = 'indent' -- Fold based on indent level
o.foldlevel = 10 -- Start unfolded
o.foldnestmax = 10 -- Max nested folds
o.foldtext = '' -- Hide default fold text
o.spelloptions = 'camel'
o.shortmess = 'CFOSWaco'

local opt = vim.opt

-- Virtual editing / keyword behaviour
opt.virtualedit = { 'block' } -- In visual block mode, cursor can move beyond end of line
opt.iskeyword:append('-') -- Treat `-` as word character, same as `_`

-- Characters for invisible items
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- UI characters
opt.fillchars = {
  eob = ' ', -- No visible ~ on empty lines
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
}

-- Diff Mode settings (taken from maria's config)
vim.opt.diffopt:append('followwrap,vertical,context:99')

-- Diagnostic configuration
local icons = require('icons')
vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = false, -- Disable gutter signs
  -- signs = vim.g.have_nerd_font and {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = icons.ERROR,
  --     [vim.diagnostic.severity.WARN] = icons.WARN,
  --     [vim.diagnostic.severity.INFO] = icons.INFO,
  --     [vim.diagnostic.severity.HINT] = icons.HINT,
  --   },
  -- } or {},
  -- virtual_lines = {
  --   current_line = true,
  --   severity = {
  --     min = vim.diagnostic.severity.ERROR,
  --   },
  -- },
  status = {
    format = function(counts)
      local items = {}
      for severity, count in pairs(counts) do
        local name = vim.diagnostic.severity[severity]
        local hl = 'DiagnosticSign' .. name:sub(1, 1) .. name:sub(2):lower()
        table.insert(
          items,
          ('%%#%s#%s %d'):format(hl, icons.diagnostics[name], count)
        )
      end
      return table.concat(items, ' ')
    end,
  },
  virtual_text = {
    -- source = 'if_many',
    -- severity = {
    --   max = vim.diagnostic.severity.WARN,
    -- },
    -- prefix = '',
    spacing = 2, -- Space before text
    format = function(diagnostic)
      -- Use shorter, nicer names for some sources:
      local special_sources = {
        ['Lua Diagnostics.'] = 'lua',
        ['Lua Syntax Check.'] = 'lua',
      }

      local message = ''
      -- local message = icons.diagnostics[vim.diagnostic.severity[diagnostic.severity]]
      if diagnostic.code then
        message = string.format('%s %s', message, diagnostic.code)
      end
      if diagnostic.source then
        message = string.format(
          '%s[%s]',
          message,
          special_sources[diagnostic.source] or diagnostic.source
        )
      end

      if message == '' then message = diagnostic.message end

      return message .. ' '
    end,
  },
  float = {
    -- source = 'if_many',
    border = 'rounded',
    -- Show severity icons as prefixes.
    prefix = function(diag)
      local level = vim.diagnostic.severity[diag.severity]
      local prefix = '▍' .. string.format(' %s ', icons.diagnostics[level])
      return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
    end,
    suffix = '',
  },
  update_in_insert = false,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  },
})

-- Ui2
require('vim._core.ui2').enable()

-- WSL clipboard integration
local function isNotEmpty(s) return s ~= nil and s ~= '' end
if isNotEmpty(vim.env.WSL_INTEROP) or isNotEmpty(vim.env.WSL_DISTRO_NAME) then
  g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.lsp.enable({
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
  'oxlint',
  'tsgo',
  'emmet_language_server',
  'lua_ls',
  'tailwindcss',
  'bashls',
  'bacon_ls',
  -- Don't install rust_analyzer with nvim, use rustup, run this:
  -- rustup component add rust-analyzer
  'rust_analyzer',
  'dartls',
  'terraformls',
})
