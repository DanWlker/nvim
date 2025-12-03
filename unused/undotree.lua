return {
  'mbbill/undotree',
  init = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    {
      '<leader>tu',
      '<cmd>UndotreeToggle<cr>',
      desc = 'Toggle undo tree',
    },
  },
}
