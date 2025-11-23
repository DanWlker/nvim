return {
  'dmmulroy/ts-error-translator.nvim',
  event = 'VimEnter', -- I don't actually know what event to use
  opts = {
    -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
    auto_attach = true,

    -- LSP server names to translate diagnostics for (default shown below)
    servers = {
      'astro',
      'svelte',
      'ts_ls',
      'tsserver', -- deprecated, use ts_ls
      'typescript-tools',
      'volar',
      'vtsls',
    },
  },
}
