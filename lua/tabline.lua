local M = {}

function M.getTabLabel(n)
  local current_win = vim.api.nvim_tabpage_get_win(n)
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local file_name = vim.api.nvim_buf_get_name(current_buf)
  file_name = vim.api.nvim_call_function('fnamemodify', { file_name, ':p:t' })
  if file_name == '' then return 'No Name' end
  local icon = require('mini.icons').get('file', file_name)
  if icon ~= nil then return icon .. ' ' .. file_name end
  return file_name
end

local function count_editable_buffers_in_tab(tab)
  local count = 0
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bo = vim.bo[buf]
    if bo.buftype == '' and bo.buflisted and bo.modifiable and not bo.readonly then
      count = count + 1
    end
  end
  return count
end

function M.render()
  local s = ''
  local tabs = vim.api.nvim_list_tabpages()
  local current = vim.api.nvim_get_current_tabpage()

  for _, tab in ipairs(tabs) do
    local is_active = (tab == current)

    local hl_left = is_active and '%#TabLinePillActiveLeft#'
      or '%#TabLinePillInactiveLeft#'
    local hl_text = is_active and '%#TabLinePillActiveText#'
      or '%#TabLinePillInactiveText#'
    local hl_right = is_active and '%#TabLinePillActiveRight#'
      or '%#TabLinePillInactiveRight#'

    s = s .. hl_left .. ''
    s = s
      .. hl_text
      .. ' '
      .. M.getTabLabel(tab)
      .. ' '
      .. '['
      .. count_editable_buffers_in_tab(tab)
      .. ']'
    s = s .. hl_right .. ''
    s = s .. '%#TabLine# '
  end

  return s
end

vim.o.tabline = "%!v:lua.require('tabline').render()"

return M
