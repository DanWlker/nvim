local map = vim.keymap.set
map({ 'i', 'n', 's' }, '<Esc>', function()
  vim.cmd('noh')

  if package.loaded['snacks'] then vim.schedule(require('snacks').notifier.hide) end

  if package.loaded['luasnip'] and require('luasnip').expand_or_jumpable() then
    vim.schedule(require('luasnip').unlink_current)
  end

  -- resend the default <esc> behavior, 'expr' doesn't work for some reason
  return '<Esc>'
end, { expr = true })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
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
map('n', '<M-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<M-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map(
  'n',
  '<M-Left>',
  '<cmd>vertical resize -2<cr>',
  { desc = 'Decrease Window Width' }
)
map(
  'n',
  '<M-Right>',
  '<cmd>vertical resize +2<cr>',
  { desc = 'Increase Window Width' }
)
map('x', '/', '<Esc>/\\%V')
map('n', 'yc', 'yy<cmd>normal gcc<cr>p')

-- window
map('n', '<C-Left>', '<C-w>h', { desc = 'Switch Window Left' })
map('n', '<C-Right>', '<C-w>l', { desc = 'Switch Window Right' })
map('n', '<C-Down>', '<C-w>j', { desc = 'Switch Window Down' })
map('n', '<C-Up>', '<C-w>k', { desc = 'Switch Window Up' })
map('n', '<C-w><S-Left>', '<C-w>H', { desc = 'Switch Window Far Left' })
map('n', '<C-w><S-Right>', '<C-w>L', { desc = 'Switch Window Far Right' })
map('n', '<C-w><S-Down>', '<C-w>J', { desc = 'Switch Window Top' })
map('n', '<C-w><S-Up>', '<C-w>K', { desc = 'Switch Window Bottom' })

-- Don't cancel me
map({ 'n', 'x' }, 'h', '<nop>') -- this is now mapped to flash nvim
map({ 'n', 'x' }, 'j', '<nop>') -- this is now mapped for jj, js, jt
map({ 'n', 'x' }, 'k', '<nop>')
map({ 'n', 'x' }, 'l', '<nop>') -- this is now mapped to mini.surround ('Lasso')
-- map('n', 'S', "m'a<CR><Esc>`'")
-- map('n', 'S', 'a<CR><Esc>')

-- Toggles
map('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = 'Toggle wrap' })
map(
  'n',
  '<leader>tW',
  '<cmd>windo set wrap!<cr>',
  { desc = 'Toggle wrap for all windows' }
)
-- map('n', '<leader>td', function()
--   vim.diagnostic.enable(not vim.diagnostic.is_enabled())
-- end, { desc = 'Toggle diagnostics' })
