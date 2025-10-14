return {
  'lewis6991/hover.nvim',
  config = function()
    require('hover').setup({
      init = function()
        -- Require providers
        require('hover.providers.lsp')
        require('hover.providers.fold_preview')
        require('hover.providers.diagnostic')
      end,
      preview_opts = {
        border = 'single',
      },
      preview_window = false,
      title = true,
    })

    -- Setup keymaps
    vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
  end,
}
