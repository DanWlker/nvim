vim.pack.add({
  'https://github.com/mistweaverco/kulala.nvim',
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
