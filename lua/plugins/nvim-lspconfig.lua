return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
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
          local highlight_augroup =
            vim.api.nvim_create_augroup('danwlker/lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = function()
              local mode = vim.fn.mode()
              if not mode:match('i') then vim.lsp.buf.document_highlight() end
            end,
          })

          vim.api.nvim_create_autocmd(
            { 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
            {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            }
          )

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup(
              'danwlker/lsp-detach',
              { clear = true }
            ),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({
                group = highlight_augroup,
                buffer = event2.buf,
              })
            end,
          })
        end

        if
          client
          and client:supports_method('textDocument/inlayHint', event.buf)
        then
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

    for server_name, server in pairs(require('external').allServers) do
      vim.lsp.config(server_name, server)
      vim.lsp.enable(server_name)
    end
  end,
}
