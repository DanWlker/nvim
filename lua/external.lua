local M = {}

M.masonInstalledServers = {
  basedpyright = {},
  tombi = {},
  helm_ls = {
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = 'yaml-language-server',
        },
      },
    },
  },
  -- graphql = {},
  marksman = {},
  -- yamlls from LazyVim
  yamlls = {
    -- vim.lsp.protocol.make_client_capabilities() already has this
    -- capabilities = {
    --   textDocument = {
    --     foldingRange = {
    --       dynamicRegistration = false,
    --       lineFoldingOnly = true,
    --     },
    --   },
    -- },
    before_init = function(_, new_config)
      new_config.settings.yaml.schemas = vim.tbl_deep_extend(
        'force',
        new_config.settings.yaml.schemas or {},
        require('schemastore').yaml.schemas()
      )
    end,
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemaStore = {
          -- Must disable built-in schemaStore support to use
          -- schemas from SchemaStore.nvim plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = '',
        },
        customTags = {
          '!reference sequence', -- this is used for gitlab templates
        },
      },
    },
  },
  -- jsonls from LazyVim
  jsonls = {
    before_init = function(_, new_config)
      new_config.settings.json.schemas = vim.tbl_deep_extend(
        'force',
        new_config.settings.json.schemas or {},
        require('schemastore').json.schemas()
      )
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },

  dockerls = {},
  docker_compose_language_service = {},

  -- Clangd from LazyVim
  clangd = {
    keys = {
      {
        '<leader>ch',
        '<cmd>ClangdSwitchSourceHeader<cr>',
        desc = 'Switch Source/Header (C/C++)',
      },
    },
    root_markers = {
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac', -- AutoTools
      'Makefile',
      'configure.ac',
      'configure.in',
      'config.h.in',
      'meson.build',
      'meson_options.txt',
      'build.ninja',
      '.git',
    },
    capabilities = {
      offsetEncoding = { 'utf-16' },
    },
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--fallback-style=llvm',
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },

  -- Go, from LazyVim
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = {
          '-.git',
          '-.vscode',
          '-.idea',
          '-.vscode-test',
          '-node_modules',
        },
        semanticTokens = true,
      },
    },
  },

  --Html, Css, Js
  -- html = {},
  superhtml = {},
  cssls = {
    -- from https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/lsp/settings/cssls.lua
    settings = {
      css = {
        lint = {
          unknownAtRules = 'ignore',
        },
      },
      scss = {
        lint = {
          unknownAtRules = 'ignore',
        },
      },
      less = {
        lint = {
          unknownAtRules = 'ignore',
        },
      },
    },
  },
  eslint = {}, -- May need to look into if this will conflict with prettier but, so far not sure

  -- TODO: Migrate to golang typescript lsp when it is done
  -- Alternate to ts_ls
  vtsls = {
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },

  -- use either emmet_language server or emmet_ls, emmet_language_server was created as an improvement
  emmet_language_server = {},
  -- emmet_ls = {
  --   init_options = {
  --     html = {
  --       options = {
  --         -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
  --         ['bem.enabled'] = true,
  --       },
  --     },
  --   },
  -- },

  -- Vue, but its messy, probably should refer to LazyVim config
  -- ts_ls = {
  --   -- init_options = {
  --   --   plugins = {
  --   --     {
  --   --       name = '@vue/typescript-plugin',
  --   --       location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
  --   --       languages = { 'javascript', 'typescript', 'vue' },
  --   --     },
  --   --   },
  --   -- },
  --   filetypes = {
  --     'vue',
  --   },
  -- },
  -- vue_ls = {},

  -- Lua
  lua_ls = {
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
  },
  tailwindcss = {
    -- exclude a filetype from the default_config
    filetypes_exclude = { 'markdown' },
    -- add additional filetypes to the default_config
    filetypes_include = {},
    -- to fully override the default_config, change the below
    filetypes = {
      'astro',
      'css',
      'heex',
      'html',
      'html-eex',
      'javascript',
      'javascriptreact',
      'rust',
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
    },
    style = 'full',
  },
  bashls = {},
  bacon_ls = {},
}

M.manuallyInstalledServers = {
  -- Don't install rust_analyzer with nvim, use rustup, run this:
  -- rustup component add rust-analyzer
  rust_analyzer = {
    cargo = {
      allFeatures = true,
      loadOutDirsFromCheck = true,
      buildScripts = {
        enable = true,
      },
    },
    -- Add clippy lints for Rust if using rust-analyzer
    checkOnSave = false, -- re-enable this if we use rust-analyzer instead of bacon-ls
    -- Enable diagnostics if using rust-analyzer
    diagnostics = {
      enable = false, -- re-enable this if we use rust-analyzer instead of bacon-ls
    },
    procMacro = {
      enable = true,
    },
    files = {
      exclude = {
        '.direnv',
        '.git',
        '.jj',
        '.github',
        '.gitlab',
        'bin',
        'node_modules',
        'target',
        'venv',
        '.venv',
      },
      -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
      watcher = 'client',
    },
  },
  dartls = {
    settings = {
      dart = {
        analysisExcludedFolders = {
          vim.fn.expand('$HOME/.pub-cache/'),
          vim.fn.expand('$HOME/fvm/'),
          vim.fn.expand('$HOME/development/flutter/'),
        },
      },
    },
  },
}

M.allServers = (function()
  return vim.tbl_extend(
    'force',
    {},
    M.masonInstalledServers,
    M.manuallyInstalledServers
  )
end)()

M.ensureInstalled = (function()
  local ensure_installed = vim.tbl_keys(M.masonInstalledServers)
  vim.list_extend(ensure_installed, {
    'stylua',
    'markdownlint-cli2',
    -- 'markdown-toc',
    'prettierd',
    'prettier',
    'golangci-lint',
    'clang-format',
    'yamllint',
    'gofumpt',
    'hadolint',
    'sqlfluff',
    'delve',
    'shellcheck', --used by bashls
    'shfmt', --used by bashls
    -- 'goimports',
    -- 'tree-sitter-cli', -- don't use this, use brew installed one
    'ruff',
    -- 'yamlfmt',
    'bacon', -- used by bacon_ls
    -- 'rustfmt', -- deprecated, install this using rustup
  })
  return ensure_installed
end)()

return M
