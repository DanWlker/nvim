return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = { ensure_installed = require('shared.tools').ensureInstalled },
  dependencies = {
    {
      'mason-org/mason-lspconfig.nvim',
      dependencies = { 'mason-org/mason.nvim' },
      opts = { automatic_enable = false },
    },
    { 'jay-babu/mason-nvim-dap.nvim', dependencies = { 'mason-org/mason.nvim' } },
    { 'mason-org/mason.nvim', config = true },
  },
}
