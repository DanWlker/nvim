return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics',
    },
    {
      '<leader>xD',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=false win.size=0.4<cr>',
      desc = 'Symbols',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.4<cr>',
      desc = 'LSP Definitions / references / ...',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List',
    },
    {
      '<C-p>',
      function()
        if require('trouble').is_open() then
          require('trouble').prev({ skip_groups = true, jump = true })
        end
      end,
      desc = 'Previous Trouble/Quickfix Item',
    },
    {
      '<C-n>',
      function()
        if require('trouble').is_open() then
          require('trouble').next({ skip_groups = true, jump = true })
        end
      end,
      desc = 'Next Trouble/Quickfix Item',
    },
    {
      '<leader>xc',
      function()
        if require('trouble').is_open() then require('trouble').close() end
      end,
      desc = 'Close',
    },
    {
      '<leader>xt',
      '<cmd>TodoTrouble<cr>',
      desc = 'Todo List',
    },
  },
  opts = {},
}
