vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('danwlker/highlight-yank', { clear = true }),
  callback = function()
    if vim.fn.has('nvim-0.13') == 1 then
      vim.hl.hl_op()
    else
      (vim.hl or vim.highlight).on_yank()
    end
  end,
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
    vim.o.hlsearch = not (mode:match('i') or mode:match('v'))
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

-- Both created once here rather than inside the LspAttach callback, so
-- clear = true is safe: it resets on re-source instead of wiping the handlers
-- registered by previously attached buffers.
local detach_augroup =
  vim.api.nvim_create_augroup('danwlker/lsp-detach', { clear = true })
local highlight_augroup =
  vim.api.nvim_create_augroup('danwlker/lsp-highlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup(
    'danwlker/lsp-attach-lspconfig',
    { clear = true }
  ),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    map(
      'K',
      function() vim.lsp.buf.hover({ border = 'rounded' }) end,
      'vim.lsp.buf.hover()'
    )
    map('gD', vim.lsp.buf.declaration, 'vim.lsp.buf.declaration()')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client:supports_method('textDocument/documentHighlight', event.buf)
    then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = function()
          local mode = vim.fn.mode()
          if not mode:match('i') then vim.lsp.buf.document_highlight() end
        end,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'ModeChanged' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- NOTE: scoped to this buffer, and the group is created once at file
      -- scope. Creating it here with clear = true would wipe the handler
      -- registered by every previously attached buffer.
      vim.api.nvim_create_autocmd('LspDetach', {
        buffer = event.buf,
        group = detach_augroup,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = highlight_augroup,
            buffer = event2.buf,
          })
        end,
      })
    end

    -- TODO: revisit https://github.com/neovim/neovim/issues/39477
    -- vim.lsp.codelens.enable(true)

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map(
        'grh',
        function()
          vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
          )
        end,
        'vim.lsp.inlay_hint.enable()'
      )
    end

    if client and client:supports_method('textDocument/documentColor') then
      map(
        'grC',
        function() vim.lsp.document_color.color_presentation() end,
        'vim.lsp.document_color.color_presentation()',
        { 'n', 'x' }
      )
    end
  end,
})
