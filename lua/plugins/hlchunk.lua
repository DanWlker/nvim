return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    chunk = {
      chars = {
        horizontal_line = '─',
        vertical_line = '│',
        left_top = '╭',
        left_bottom = '╰',
        right_arrow = '─',
      },
      style = {
        '#9399b2',
        '#eba0ac',
      },
      enable = true,
      duration = 0,
      delay = 0,
    },
    indent = {
      enable = false,
    },
    line_num = {
      enable = false,
    },
    blank = {
      enable = false,
    },
  },
}
