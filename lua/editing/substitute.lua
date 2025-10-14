return {
  'gbprod/substitute.nvim',
  opts = {
    yank_substituted_text = true,
    highlight_substituted_text = {
      timer = 150,
    },
  },
  keys = {
    {
      's',
      function() require('substitute').operator() end,
      desc = 'Substitute',
    },
    {
      's',
      function() require('substitute').visual() end,
      mode = 'x',
      desc = 'Substitute',
    },
    {
      'S',
      function() require('substitute').eol() end,
      mode = { 'n', 'x' },
      desc = 'Substitute to eol',
    },
    {
      'ss',
      function() require('substitute').line() end,
      desc = 'Substitute line',
    },
  },
}
