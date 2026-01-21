return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  keys = {
    {
      '<leader>gh',
      '<cmd>CodeDiff history<cr>',
      desc = 'Git History',
    },
    {
      '<leader>gf',
      '<cmd>CodeDiff history %<cr>',
      desc = 'Git File Only History',
    },
  },
  cmd = 'CodeDiff',
}
