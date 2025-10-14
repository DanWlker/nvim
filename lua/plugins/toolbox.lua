return {
  'DanWlker/toolbox.nvim',
  keys = {
    {
      '<leader>fs',
      function()
        require('toolbox').show_picker(nil, {
          prompt = 'Toolbox ',
        })
      end,
      desc = 'Find Shortcuts in Toolbox',
      mode = { 'n', 'v' },
    },
  },
  opts = {
    commands = {
      {
        name = 'Tab: Close',
        execute = 'tabclose',
      },
      {
        name = 'Json: Format',
        execute = "%!jq '.'",
      },
      {
        name = 'Print: Vim table',
        execute = function(v) print(vim.inspect(v)) end,
      },
      {
        name = 'Copy: Relative path without file',
        execute = function()
          local path = vim.fn.expand('%:.')
          local dir = path:match('(.*/)')
          vim.fn.setreg('+', dir)
        end,
      },
      {
        name = 'Copy: Relative path',
        execute = function()
          local path = vim.fn.expand('%:.')
          vim.fn.setreg('+', path)
        end,
      },
      {
        name = 'Copy: Absolute path',
        execute = function()
          local path = vim.fn.expand('%:p')
          vim.fn.setreg('+', path)
        end,
      },
      {
        name = 'Copy: Vim table',
        execute = function(v) vim.fn.setreg('+', vim.inspect(v)) end,
      },
      {
        name = 'Plugin: Reload',
        execute = function(name)
          package.loaded[name] = nil
          require(name).setup()
        end,
      },
      {
        name = 'Csv: Align',
        execute = 'RainbowAlign',
      },
      {
        name = 'Csv: Shrink',
        execute = 'RainbowShrink',
      },
      {
        name = 'Conform: Format buffer',
        execute = function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
      },
      {
        name = 'Sql: Open Ui',
        execute = function()
          vim.cmd('tabnew')
          vim.cmd('DBUI')
          vim.cmd('set shiftwidth=2')
        end,
      },
      {
        name = 'Sql: Add Connection',
        execute = 'DBUIAddConnection',
      },
      {
        name = 'Sql: Clear Cache',
        execute = 'DBCompletionClearCache',
      },
      {
        name = 'Sql: Format',
        execute = '!sleek',
      },
      {
        name = 'Coverage: Load and Show, also listen to coverage changes',
        execute = 'Coverage',
      },
      {
        name = 'Coverage: Toggle signs',
        execute = 'CoverageToggle',
      },
      {
        name = 'Coverage: Clear, stop listening to coverage changes',
        execute = 'CoverageClear',
      },
      {
        name = 'Coverage: Summary',
        execute = 'CoverageSummary',
      },
      {
        name = 'Lsp: Info',
        execute = 'LspInfo',
      },
      {
        name = 'Lint: Info',
        execute = 'LintInfo',
      },
      {
        name = 'Conform: Info',
        execute = 'ConformInfo',
      },
      {
        name = 'Scratch: Toggle buffer',
        execute = function() require('snacks').scratch() end,
      },
      {
        name = 'Scratch: Select buffer',
        execute = function() require('snacks').scratch.select() end,
      },
      {
        name = 'Undotree: Focus',
        execute = 'UndotreeFocus',
      },
    },
  },
}
