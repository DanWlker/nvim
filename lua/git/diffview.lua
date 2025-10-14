return {
  'sindrets/diffview.nvim',
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
}
