return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  lazy = true,
  build = 'make install_jsregexp',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip').filetype_extend('javascriptreact', { 'html' })
    require('luasnip').filetype_extend('typescriptreact', { 'html' })
    require('luasnip').filetype_extend('svelte', { 'html' })
    require('luasnip').filetype_extend('vue', { 'html' })
    require('luasnip').filetype_extend('php', { 'html' })
    require('luasnip').filetype_extend('javascript', { 'javascriptreact' })
    require('luasnip').filetype_extend('typescript', { 'typescriptreact' })
    require('luasnip').filetype_extend('dart', { 'flutter' })
    require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })
  end,
}
