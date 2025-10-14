return {
  'nvim-mini/mini-git',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'mini.git',
  config = function()
    require('mini.git').setup({})

    -- Use only HEAD name as summary string
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniGitUpdated',
      group = vim.api.nvim_create_augroup(
        'danwlker/mini-git-head',
        { clear = true }
      ),
      callback = function(data)
        -- Utilize buffer-local table summary
        local summary = vim.b[data.buf].minigit_summary
        vim.b[data.buf].minigit_summary_string = summary.head_name or ''
      end,
    })
  end,
}
