vim.g.undotree_SetFocusWhenToggle = 1
return {
  'mbbill/undotree',
  keys = {
    {
      '<leader>tu',
      '<cmd>UndotreeToggle<cr>',
      desc = 'Toggle undo tree',
    },
  },
}
