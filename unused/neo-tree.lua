return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    popup_border_style = 'rounded',
    enable_git_signs = false,
    enable_diagnostics = false,
    default_component_configs = {
      file_size = { enabled = false },
      type = { enabled = false },
      last_modified = { enabled = false },
      created = { enabled = false },
      symlink_target = { enabled = true },
      hijacs_netrw_behavior = 'open_default',
    },
    filesystem = {
      filtered_items = {
        visible = true,
        never_show = { '.git', '.github', 'node_modules' },
      },
      window = {
        position = 'float',
        mappings = {
          ['\\'] = 'close_window',
          ['E'] = 'expand_all_nodes',
          ['w'] = 'close_node',
          ['W'] = 'close_all_nodes',
        },
      },
    },
  },
}
