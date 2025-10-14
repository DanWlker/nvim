-- Lazy
return {
  'piersolenski/import.nvim',
  opts = {
    picker = 'snacks',
    insert_at_top = false,
  },
  keys = {
    {
      '<leader>fi',
      function() require('import').pick() end,
      desc = 'Find Import',
    },
  },
}
