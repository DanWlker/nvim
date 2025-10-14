local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true

-- disable netrw (copied from nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

local o = vim.o
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.mouse = 'a'
vim.schedule(function() o.clipboard = 'unnamedplus' end)
o.breakindent = true
o.breakindentopt = 'list:-1'
o.linebreak = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.timeoutlen = 500
o.splitright = true
o.splitbelow = true
o.list = false
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 12
o.sidescrolloff = 12
o.cursorlineopt = 'number'
o.laststatus = 3 -- global statusline
o.termguicolors = true -- True color support
o.jumpoptions = 'stack' -- Make jumplist more intuitive
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep'
o.shiftround = true
o.smartindent = true
o.wrap = false
o.confirm = true
o.swapfile = false
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
o.pumheight = 10
o.shortmess = 'CFOSWaco'
o.formatoptions = 'rqnl1j'
o.infercase = true
o.shiftwidth = 2
o.spelloptions = 'camel'
-- o.splitkeep = 'screen'
o.foldlevel = 10
o.foldmethod = 'indent'
o.foldnestmax = 10
o.foldtext = ''
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
o.complete = '.,w,b,kspell'
o.completeopt = 'menuone,noselect,fuzzy,nosort'

local opt = vim.opt
opt.virtualedit = { 'block' } -- in visual block mode, cursor can move beyond end of line
opt.iskeyword:append('-') -- treat `-` as word character, same as `_`
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.fillchars = {
  eob = ' ',
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
}

local icons = require('icons')
vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = false,
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

  virtual_text = {
    -- source = 'if_many',
    -- severity = {
    --   max = vim.diagnostic.severity.WARN,
    -- },
    -- prefix = '',
    spacing = 2,
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
})

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
