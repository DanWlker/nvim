return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoFzfLua' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}
