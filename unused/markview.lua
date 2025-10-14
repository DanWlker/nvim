return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  opts = {
    hybrid_modes = { 'n' },
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].conecalcursor = 'c'
      end,
    },
  },
}
