vim.api.nvim_create_user_command(
  'AtoneFocus',
  function() vim.cmd('Atone focus') end,
  { desc = 'Undotree Focus' }
)

return {
  'XXiaoA/atone.nvim',
  cmd = { 'Atone' },
  opts = {
    ui = {
      compact = true,
    },
  }, -- your configuration here
  keys = {
    {
      '<leader>tu',
      '<cmd>Atone toggle<cr>',
      desc = 'Toggle undo tree',
    },
  },
}
