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
          vim.keymap.set(
            mode,
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end

        map('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, '')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

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
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

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
            'LSP: Inlay Hint'
          )
        end

        -- if
        --   client and client:supports_method('textDocument/documentColor', event.buf)
        -- then
        --   vim.lsp.document_color.enable(true, event.buf)
        -- end
      end,
    })

    for server_name, server in pairs(require('shared.tools').allServers) do
      vim.lsp.config(server_name, server)
      vim.lsp.enable(server_name)
    end
  end,
}
