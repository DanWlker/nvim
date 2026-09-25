--- All `lua/` dirs on 'runtimepath' (plugins, VIMRUNTIME, this config).
--- Used as `workspace.packages` so the parent dir is the require root but only
--- the `lua/` tree gets indexed, which keeps `require('snacks')` resolvable
--- without scanning each plugin's docs/tests.
local function runtime_lua_dirs()
  local dirs = {}
  for _, dir in ipairs(vim.api.nvim_get_runtime_file('lua/', true)) do
    dirs[#dirs + 1] = (dir:gsub('/$', ''))
  end
  return dirs
end

return {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)
    -- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (
          vim.uv.fs_stat(path .. '/.emmyrc.json')
          or vim.uv.fs_stat(path .. '/.luarc.json')
        )
      then
        client.config.settings = {}
      end
    end
  end,
  settings = {
    emmylua = {
      -- Tell the server which Lua you're using (usually LuaJIT, for Neovim).
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        disable = {
          -- Plugin `@class` opts are rarely marked optional, so every
          -- `setup({...})` call looks like it's missing required fields.
          'missing-fields',
          -- Same root cause, reported separately as "expected `FooOpts?` but
          -- found `{...}`". Uncomment to silence those too.
          -- 'param-type-mismatch',
        },
        globals = {
          'vim',
          -- You can add globals here to make emmylua aware of them
          'MiniIcons',
          'Snacks',
        },
      },
      -- Make the server aware of Neovim runtime files.
      workspace = {
        packages = runtime_lua_dirs(),
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
}
