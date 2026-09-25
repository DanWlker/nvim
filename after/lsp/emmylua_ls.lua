--- A plugin that ships its test suite inside `lua/` gets indexed along with
--- everything else, and its stubs then pollute the real types -- diffview's
--- `vim.cmd = function() end` makes `vim.cmd('...')` report `redundant-parameter`
--- and sends go-to-definition into the spec file. Skip test trees.
--- Scoped per package rather than set workspace-wide, so a Lua project of your
--- own still gets diagnostics in its own tests.
local ignore_globs = {
  '**/tests/**',
  '**/test/**',
  '**/spec/**',
  '**/*_spec.lua',
  '**/*_test.lua',
}

--- All `lua/` dirs on 'runtimepath' (plugins, VIMRUNTIME, this config).
--- Used as `workspace.packages` so the parent dir is the require root but only
--- the `lua/` tree gets indexed, which keeps `require('snacks')` resolvable
--- without scanning each plugin's docs/tests.
local function runtime_lua_dirs()
  local dirs = {}
  for _, dir in ipairs(vim.api.nvim_get_runtime_file('lua/', true)) do
    dirs[#dirs + 1] = {
      path = vim.uv.fs_realpath(dir) or (dir:gsub('/$', '')),
      ignoreGlobs = ignore_globs,
    }
  end
  return dirs
end

return {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)
    if not client.workspace_folders then return end
    local root = client.workspace_folders[1].name

    -- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
    if
      root ~= vim.fn.stdpath('config')
      and (
        vim.uv.fs_stat(root .. '/.emmyrc.json')
        or vim.uv.fs_stat(root .. '/.luarc.json')
      )
    then
      client.config.settings = {}
      return
    end

    -- Drop the workspace's own `lua/` from the package list. A dir listed there
    -- is a *library*, and emmylua reports no diagnostics inside libraries -- so
    -- leaving it in silences every warning under `lua/`. Requires into it still
    -- resolve: emmylua handles the `lua/` prefix for workspace files natively.
    -- `client.config` is already a per-client deepcopy (see `vim.lsp.enable`),
    -- so editing it here can't leak into the next workspace.
    root = vim.uv.fs_realpath(root) or root
    local workspace = client.config.settings.emmylua.workspace
    local packages = {}
    for _, pkg in ipairs(workspace.packages) do
      if not vim.startswith(pkg.path .. '/', root .. '/') then
        packages[#packages + 1] = pkg
      end
    end
    workspace.packages = packages
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
