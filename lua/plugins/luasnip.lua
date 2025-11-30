return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  lazy = true,
  build = 'make install_jsregexp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.filetype_extend('javascriptreact', { 'html' })
    luasnip.filetype_extend('typescriptreact', { 'html' })
    luasnip.filetype_extend('svelte', { 'html' })
    luasnip.filetype_extend('vue', { 'html' })
    luasnip.filetype_extend('php', { 'html' })
    luasnip.filetype_extend('javascript', { 'javascriptreact' })
    luasnip.filetype_extend('typescript', { 'typescriptreact' })
    luasnip.filetype_extend('dart', { 'flutter' })
    require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })
  end,
}
