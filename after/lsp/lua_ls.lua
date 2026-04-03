return {
  settings = {
    Lua = {
      doc = {
        privateName = { '^_' },
      },
      completion = {
        callSnippet = 'Replace',
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      diagnostics = {
        disable = { 'missing-fields' },
      },
    },
  },
}
