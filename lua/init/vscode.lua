local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '

local o = vim.o
o.clipboard = 'unnamedplus'
o.timeoutlen = 500

local map = vim.keymap.set
map('n', 'Q', '<nop>')
map(
  'n',
  'gco',
  'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>',
  { desc = 'Add Comment Below' }
)
map(
  'n',
  'gcO',
  'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>',
  { desc = 'Add Comment Above' }
)
map('x', '/', '<Esc>/\\%V')
map('n', 'yc', 'yy<cmd>normal gcc<cr>p')
map({ 'n', 'x' }, 'h', '<nop>') -- this is now mapped to flash nvim
map({ 'n', 'x' }, 'j', '<nop>') -- this is now mapped for jj, js, jt
map({ 'n', 'x' }, 'k', '<nop>')
map({ 'n', 'x' }, 'l', '<nop>') -- this is now mapped to mini.surround ('Lasso')

map('n', 'za', function() require('vscode').action('editor.toggleFold') end)
map('n', 'zR', function() require('vscode').action('editor.unfoldAll') end)
map('n', 'zM', function() require('vscode').action('editor.foldAll') end)
map('n', '\\', function() require('vscode').action('workbench.view.explorer') end)
map('n', '[d', function() require('vscode').action('editor.action.marker.prev') end)
map('n', ']d', function() require('vscode').action('editor.action.marker.next') end)
map(
  'n',
  '<leader>ff',
  function() require('vscode').action('workbench.action.quickOpen') end
)
map(
  'n',
  '<leader>fg',
  function() require('vscode').action('workbench.action.findInFiles') end
)
map(
  'n',
  '<leader>fc',
  function() require('vscode').action('workbench.action.showCommands') end
)
map('n', 'u', function() require('vscode').action('undo') end)
map('n', '<c-r>', function() require('vscode').action('redo') end)
map(
  'n',
  '<c-w>d',
  function() require('vscode').action('editor.action.showHover') end
)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('danwlker/highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

require('bootstrap-lazy')

require('lazy').setup({
  { import = 'editing' },

  -- require 'plugins.nvim-autopairs', -- doesn't work
  require('catppuccin'),
})

vim.cmd.colorscheme('catppuccin')
