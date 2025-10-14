return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoFzfLua' },
  opts = { signs = false },
}
