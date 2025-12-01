require('bootstrap-lazy')

require('options')

require('keymaps')

require('autocmds')

require('commands')

require('statusline')

require('tabline')

require('winbar')

require('lazy').setup({
  -- [[ Language helpers ]]
  { import = 'lang' },

  -- [[ Git ]]
  { import = 'git' },

  -- [[ Plugins ]]
  { import = 'plugins' },

  -- [[ Editing ]]
  { import = 'editing' },

  -- [[ Editing ]]
  { import = 'themes' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  change_detection = { notify = false },
})

vim.cmd.colorscheme('catppuccin')
