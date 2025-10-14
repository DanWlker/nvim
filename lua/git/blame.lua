return {
  'FabijanZulj/blame.nvim',
  keys = {
    {
      '<leader>gl',
      '<cmd>BlameToggle window<cr>',
      desc = 'Git Blame List',
    },
  },
  opts = {
    blame_options = { '-w' },
  },
}
