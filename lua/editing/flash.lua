return {
  'folke/flash.nvim',
  opts = {
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      'h',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
          search = {
            multi_window = false,
          },
        })
      end,
      desc = 'Flash Hop (On the character)',
    },
    {
      'H',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
          search = {
            multi_window = false,
          },
          jump = {
            pos = 'end',
            inclusive = false,
          },
        })
      end,
      desc = 'Flash Hop (One character before)',
    },
  },
}
