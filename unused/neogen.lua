-- This is from LazyVim
return {
  'danymat/neogen',
  cmd = 'Neogen',
  keys = {
    {
      '<leader>cn', -- Idk what to put for this
      function() require('neogen').generate() end,
      desc = 'Generate Annotations (Neogen)',
    },
  },
  opts = function(_, opts)
    if opts.snippet_engine ~= nil then return end

    -- local map = {
    --   ['LuaSnip'] = 'luasnip',
    --   ['nvim-snippy'] = 'snippy',
    --   ['vim-vsnip'] = 'vsnip',
    -- }
    --
    -- for plugin, engine in pairs(map) do
    --   if LazyVim.has(plugin) then
    --     opts.snippet_engine = engine
    --     return
    --   end
    -- end
    opts.snippet_engine = 'luasnip'

    -- if vim.snippet then
    --   opts.snippet_engine = 'nvim'
    -- end
  end,
}
