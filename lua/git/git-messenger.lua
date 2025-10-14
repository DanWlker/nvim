return {
  'rhysd/git-messenger.vim',
  init = function()
    vim.g.git_messenger_no_default_mappings = true
    vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
  end,
  keys = {
    {
      '<leader>gb',
      '<Plug>(git-messenger)',
      desc = 'Git Blame',
    },
  },
  cmd = { 'GitMessenger' },
}
