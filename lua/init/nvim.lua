require('bootstrap-lazy')

require('options')

require('keymaps')

require('autocmds')

require('statusline')

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

  -- require('catppuccin'),
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

-- vim.cmd.colorscheme('catppuccin')
