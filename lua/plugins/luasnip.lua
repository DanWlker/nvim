return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  lazy = true,
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip').filetype_extend('dart', { 'flutter' })
    require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })
  end,
}
