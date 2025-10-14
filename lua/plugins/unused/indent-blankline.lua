-- local highlight = {
--   'Whitespace',
--   'CursorColumn',
-- }
return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'ibl',
  opts = {
    indent = {
      char = '▏', -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
    },
    scope = {
      show_start = false,
      show_end = false,
    },
    -- indent = { highlight = highlight, char = '' },
    -- whitespace = {
    --   highlight = highlight,
    --   remove_blankline_trail = false,
    -- },
    -- scope = { enabled = false },
  },
}
