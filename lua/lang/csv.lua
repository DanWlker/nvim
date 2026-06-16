vim.pack.add({
  'https://github.com/hat0uma/csvview.nvim',
})

-- hat0uma/csvview.nvim
require('csvview').setup({
  keymaps = {
    -- Text objects for selecting fields
    textobject_field_inner = { 'if', mode = { 'o', 'x' } },
    textobject_field_outer = { 'af', mode = { 'o', 'x' } },
    -- Excel-like navigation:
    -- Use <Tab> and <S-Tab> to move horizontally between fields.
    -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
    -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
    jump_next_field_end = { '<Tab>', mode = { 'n', 'x' } },
    jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'x' } },
    jump_next_row = { '<Enter>', mode = { 'n', 'x' } },
    jump_prev_row = { '<S-Enter>', mode = { 'n', 'x' } },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'csv', 'tsv' },
  desc = 'Enable CSV View on .csv files',
  callback = function() require('csvview').enable() end,
})

-- enable because this config loads when the file type is detected
-- however the autocmd does not run immediately
require('csvview').enable()
