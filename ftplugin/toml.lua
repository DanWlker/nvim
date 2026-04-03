local filename = vim.fn.expand('%:t')

if filename == 'Cargo.toml' then
  vim.pack.add({
    'https://github.com/saecki/crates.nvim',
  })

  -- saecki/crates.nvim
  require('crates').setup({
    completion = {
      crates = {
        enabled = true,
      },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  })
end
