return {
  'f-person/git-blame.nvim',
  init = function()
    vim.g.gitblame_enabled = 0
    -- vim.g.gitblame_display_virtual_text = 0
    -- vim.g.gitblame_schedule_event = 'CursorHold'
    -- vim.g.gitblame_clear_event = 'CursorHoldI'
  end,
  keys = {
    {
      '<leader>gcs',
      '<cmd>GitBlameCopySHA<cr>',
      desc = 'Git Copy SHA',
    },
    {
      '<leader>gcf',
      '<cmd>GitBlameCopyFileURL<cr>',
      desc = 'Git Copy File URL',
    },
    {
      '<leader>gcc',
      '<cmd>GitBlameCopyCommitURL<cr>',
      desc = 'Git Copy Commit URL',
    },

    {
      '<leader>gof',
      '<cmd>GitBlameOpenFileURL<cr>',
      desc = 'Git Open File URL',
    },
    {
      '<leader>goc',
      '<cmd>GitBlameOpenCommitURL<cr>',
      desc = 'Git Open Commit URL',
    },
  },
}
