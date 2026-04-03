vim.pack.add({
  'https://github.com/leoluz/nvim-dap-go',
})

-- leoluz/nvim-dap-go
require('dap-go').setup({
  delve = {
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    detached = vim.fn.has('win32') == 0,
  },
  dap_configurations = {
    -- https://github.com/golang/vscode-go/wiki/debugging#launchjson-attributes
    -- https://stackoverflow.com/a/70661460
    -- dlv debug -l 127.0.0.1:38697 --headless main.go
    {
      type = 'go',
      name = 'Delve Attach (127.0.0.1:38697)',
      debugAdapter = 'dlv-dap',
      mode = 'remote',
      request = 'attach',
      port = 38697,
      host = '127.0.0.1',
    },
  },
})
