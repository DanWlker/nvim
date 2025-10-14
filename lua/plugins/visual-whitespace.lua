return {
  'mcauley-penney/visual-whitespace.nvim',
  event = 'ModeChanged *:[vV\22]',
  keys = {
    {
      '<leader>tv',
      function() require('visual-whitespace').toggle() end,
      desc = 'Toggle visual-whitespace',
    },
  },
  opts = {
    --   nl_char = '󰌑',
    ignore = {
      buftypes = {
        'nofile',
        'help',
        'quickfix',
      },
    },
  },
}
