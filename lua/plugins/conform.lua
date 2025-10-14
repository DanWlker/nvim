local prettier = { 'prettierd', 'prettier', stop_after_first = true }

-- local disable_filetypes = {}
local prefer_lsp = {}
local fallback_to_lsp = { ['lua'] = true }

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  init = function()
    -- Use conform for gq.
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Reenable when needed
      -- if disable_filetypes[vim.bo[bufnr].filetype] then
      --   return nil
      -- end

      local to_return = { timeout_ms = 500 }
      -- Reenable when needed
      if prefer_lsp[vim.bo[bufnr].filetype] then
        to_return['lsp_format'] = 'prefer'
      elseif fallback_to_lsp[vim.bo[bufnr].filetype] then
        to_return['lsp_format'] = 'fallback'
      else
        -- -- should be safe to put this as default, most people and projects have lsp
        -- -- and lsp is usually the priority? I think
        to_return['lsp_format'] = 'last'
        --
      end

      -- Why not use 'fallback'?
      -- Gopls should be prioritised
      -- And usually LSP is done by the language designers? so.. in that case
      -- if they provide a formatter, we should use it.
      -- 'first' also not suitable for the same reason
      -- 'prefer' is different from not specfiying because not specfiying means uting trim_whitespace and trim_newlines
      -- 'never' is in cases like maybe javascript? where we only want to use prettier but in this case i think 'last' works as well

      return to_return
    end,
    formatters = {
      sqlfluff = {
        args = { 'format', '--dialect=ansi', '-' },
      },
      -- ['markdown-toc'] = {
      --   condition = function(_, ctx)
      --     for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
      --       if line:find '<!%-%- toc %-%->' then
      --         return true
      --       end
      --     end
      --   end,
      -- },
      -- ['markdownlint-cli2'] = {
      --   condition = function(_, ctx)
      --     local diag = vim.tbl_filter(function(d)
      --       return d.source == 'markdownlint'
      --     end, vim.diagnostic.get(ctx.buf))
      --     return #diag > 0
      --   end,
      -- },
      prettier = { require_cwd = true },
    },
    formatters_by_ft = {
      c = { 'clang-format' },
      -- go = { 'goimports' }, -- 'gofumpt' is lsp handled, slows down gopls if configured here
      javascript = prettier,
      javascriptreact = prettier,
      json = prettier,
      jsonc = prettier,
      lua = { 'stylua' },
      markdown = prettier, -- markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      scss = prettier,
      sql = { 'sqlfluff' },
      typescript = prettier,
      typescriptreact = prettier,
      yaml = prettier,
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },
  },
}
