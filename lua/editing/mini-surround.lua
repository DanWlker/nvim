return {
  'nvim-mini/mini.surround',
  keys = function(_, keys)
    -- Populate the keys based on the user's options
    local plugin = require('lazy.core.config').spec.plugins['mini.surround']
    local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
    local mappings = {
      { opts.mappings.add, desc = 'Add Matching', mode = { 'n', 'v' } },
      { opts.mappings.delete, desc = 'Delete Matching' },
      { opts.mappings.find, desc = 'Find Right Matching' },
      { opts.mappings.find_left, desc = 'Find Left Matching' },
      { opts.mappings.highlight, desc = 'Highlight Matching' },
      { opts.mappings.replace, desc = 'Replace Matching' },
    }
    mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = 'l', -- Add surrounding in Normal and Visual modes
      delete = 'ld', -- Delete surrounding
      find = '', -- Find surrounding (to the right)
      find_left = '', -- Find surrounding (to the left)
      highlight = '', -- Highlight surrounding
      replace = 'lr', -- Replace surrounding
    },
  },
}
