return {
  'kristijanhusak/vim-dadbod-ui',
  -- NOTE: This must be loaded before
  dependencies = {
    'tpope/vim-dadbod',
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
  -- NOTE: This is commented on purpose
  -- opts = {},
}
