return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = { ensure_installed = require('external').ensureInstalled },
  -- NOTE: These must be loaded before
  dependencies = {
    'jay-babu/mason-nvim-dap.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
}
