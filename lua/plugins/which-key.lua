return {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    preset = 'helix',
    delay = 500,
    keys = {
      scroll_down = '',
      scroll_up = '',
    },
    icons = {
      -- mappings = vim.g.have_nerd_font,
      mappings = false,
    },

    spec = {
      { '<leader>x', group = 'Trouble' },
      { '<leader>f', group = '[F]ind', mode = { 'n', 'x' } },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>g', group = '[G]it' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>a', group = '[A]i' },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { 'j', mode = { 'n' } }, -- for mini.splitjoin
    },
  },
}
