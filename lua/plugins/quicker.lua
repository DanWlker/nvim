return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  opts = {
    borders = {
      -- Thinner separator.
      vert = require('icons').misc.vertical_bar,
    },
  },
  keys = {
    {
      '<leader>tl',
      function() require('quicker').toggle({ loclist = true }) end,
      desc = 'Toggle loclist',
    },
    {
      '<leader>tq',
      function() require('quicker').toggle() end,
      desc = 'Toggle quickfix',
    },
  },
  config = true,
}
