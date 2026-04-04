return {
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
}
