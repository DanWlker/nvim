return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  lazy = true,
  build = 'make install_jsregexp',
  config = function()
    local luasnip = require('luasnip')
    local luasnip_loaders_vscode = require('luasnip.loaders.from_lua')

    luasnip_loaders_vscode.lazy_load()
    luasnip.filetype_extend('javascriptreact', { 'html' })
    luasnip.filetype_extend('typescriptreact', { 'html' })
    luasnip.filetype_extend('svelte', { 'html' })
    luasnip.filetype_extend('vue', { 'html' })
    luasnip.filetype_extend('php', { 'html' })
    luasnip.filetype_extend('javascript', { 'javascriptreact' })
    luasnip.filetype_extend('typescript', { 'typescriptreact' })
    luasnip.filetype_extend('dart', { 'flutter' })
    luasnip_loaders_vscode.load({ paths = { './snippets' } })
  end,
}
