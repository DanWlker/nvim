return {
  -- Linting
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    vim.api.nvim_create_user_command('LintInfo', function()
      local filetype = vim.bo.filetype
      local linters = require('lint').linters_by_ft[filetype]

      if linters then
        vim.notify('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
      else
        vim.notify('No linters configured for filetype: ' .. filetype)
      end
    end, {})

    -- local golangcilint = lint.linters.golangcilint
    -- -- Add wsl to golangcilint
    -- -- https://github.com/bombsimon/wsl?tab=readme-ov-file
    -- table.insert(golangcilint.args, '--enable')
    -- table.insert(golangcilint.args, 'wsl')

    lint.linters_by_ft = {
      markdown = { 'markdownlint-cli2' },
      go = { 'golangcilint' },
      -- yaml = { 'yamllint' }, -- Too noisy
      dockerfile = { 'hadolint' },
      sql = { 'sqlfluff' },
      mysql = { 'sqlfluff' },
      plsql = { 'sqlfluff' },
    }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('danwlker/lint', { clear = true }),
      callback = function()
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
