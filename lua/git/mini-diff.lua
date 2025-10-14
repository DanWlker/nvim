return {
  'nvim-mini/mini.diff',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '<leader>gd',
      function() require('mini.diff').toggle_overlay(0) end,
      desc = 'Git Diff',
    },
  },
  opts = {
    view = {
      style = 'sign',
      signs = {
        add = '▎',
        change = '▎',
        delete = '',
      },
    },
  },
}
