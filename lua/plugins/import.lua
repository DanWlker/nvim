-- Lazy
return {
  'piersolenski/import.nvim',
  dependencies = {
    -- One of the following pickers is required:
    -- 'nvim-telescope/telescope.nvim',
    'DanWlker/snacks.nvim',
    -- 'ibhagwan/fzf-lua',
  },
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
