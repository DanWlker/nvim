return {
  'mason-org/mason-lspconfig.nvim',
  lazy = true,
  -- NOTE: These must be loaded before
  dependencies = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = { automatic_enable = false },
}
