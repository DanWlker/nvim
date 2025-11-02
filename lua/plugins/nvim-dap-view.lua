return {
  'igorlfs/nvim-dap-view',
  lazy = true,
  opts = {
    winbar = {
      sections = {
        'scopes',
        'breakpoints',
        'threads',
        'exceptions',
        'repl',
        'console',
      },
      default_section = 'scopes',
    },
    switchbuf = 'usetab,uselast',
  },
  keys = {
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      '<cmd>DapViewToggle<cr>',
      desc = 'Debug: See last session result.',
    },
  },
}
