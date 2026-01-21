return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen' },
  keys = {
    {
      '<leader>gh',
      '<cmd>DiffviewFileHistory<cr>',
      desc = 'Git History',
    },
    {
      '<leader>gf',
      '<cmd>DiffviewFileHistory %<cr>',
      desc = 'Git File Only History',
    },
  },
  opts = {
    view = {
      default = {
        layout = 'diff2_vertical',
      },
    },
  },
}
