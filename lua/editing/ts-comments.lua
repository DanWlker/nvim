return {
  'folke/ts-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    lang = {
      vue = {
        '<!-- %s -->',
        script_element = '// %s',
      },
      kitty = '# %s',
    },
  },
}
