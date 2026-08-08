return {
  on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', {
      buffer = bufnr,
      desc = 'Switch Source/Header (C/C++)',
    })
  end,
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
    'Makefile',
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
}
