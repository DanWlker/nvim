return {
  'igorlfs/nvim-dap-view',
  opts = {},
  keys = {
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      '<cmd>DapViewOpen<cr>',
      desc = 'Debug: See last session result.',
    },
  },
}
