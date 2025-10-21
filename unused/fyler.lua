return {
  'A7Lavinraj/fyler.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
    'folke/snacks.nvim', -- to use the rename function
  },
  opts = {
    default_explorer = true,
    mappings = {
      ['\\'] = 'CloseView',
      ['<C-v>'] = 'SelectVSplit',
      ['<C-s>'] = 'SelectSplit',
    },
    win = {
      border = 'rounded',
      kind = 'float',
      win_opts = {
        relativenumber = false,
        number = false,
        signcolumn = 'yes',
      },
    },
    git_status = {
      enabled = false,
    },
    icon = {
      directory_expanded = '',
    },
    hooks = {
      on_rename = function(src_path, destination_path)
        Snacks.rename.on_rename_file(src_path, destination_path)
      end,
    },
  },
  keys = {
    {
      '\\',
      function() require('fyler').open() end,
    },
  },
}
