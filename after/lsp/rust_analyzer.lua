return {
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
}
