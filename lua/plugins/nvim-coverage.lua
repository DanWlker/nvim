return {
  'andythigpen/nvim-coverage',
  cmd = { 'Coverage', 'CoverageToggle', 'CoverageSummary' },
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    commands = true,
    auto_reload = true,
    highlights = {
      covered = { fg = '#C3E88D' },
      uncovered = { fg = '#F07178' },
    },
    signs = {
      covered = { hl = 'CoverageCovered', text = '▎' },
      uncovered = { hl = 'CoverageUncovered', text = '▎' },
    },
    summary = {
      min_coverage = 80.0,
    },
  },
}
