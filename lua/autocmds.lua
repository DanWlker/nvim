vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('danwlker/highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = vim.api.nvim_create_augroup('danwlker/checktime', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = vim.api.nvim_create_augroup('danwlker/resize-splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    local mode = vim.fn.mode()
    if mode:match('i') or mode:match('v') then
      vim.opt.hlsearch = false -- hide in insert mode
    else
      vim.opt.hlsearch = true -- show in normal / visual / command modes
    end
  end,
  group = vim.api.nvim_create_augroup('danwlker/toggle-hlsearch', { clear = true }),
  desc = 'Show search highlights in normal mode, hide in insert mode',
})

-- yankring
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('danwlker/yankring', { clear = true }),
  callback = function()
    if vim.v.event.operator == 'y' then
      for i = 9, 1, -1 do -- Shift all numbered registers.
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
      end
    end
  end,
})
