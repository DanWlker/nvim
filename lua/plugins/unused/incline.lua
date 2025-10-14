return {
  'b0o/incline.nvim',
  config = function()
    local helpers = require('incline.helpers')
    local devicons = require('nvim-web-devicons')
    require('incline').setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then filename = '[No Name]' end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local function get_diagnostic_label()
          local icons = require('shared.icons')
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(
              props.buf,
              { severity = vim.diagnostic.severity[severity] }
            )
            if n > 0 then
              table.insert(
                label,
                { ' ' .. icon .. n .. ' ', group = 'DiagnosticSign' .. severity }
              )
            end
          end
          if #label > 0 then table.insert(label, { '│ ' }) end
          return label
        end

        return {
          { get_diagnostic_label() },
          ft_icon and {
            ' ',
            ft_icon,
            ' ',
            guibg = ft_color,
            guifg = helpers.contrast_color(ft_color),
          } or '',
          ' ',
          { filename, gui = modified and 'bold,italic' or 'bold' },
          ' ',
        }
      end,
    })
  end,
  event = 'VimEnter',
}
