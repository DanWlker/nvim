local M = {}

--- Diagnostic severities.
M.diagnostics = {
  ERROR = '󰅚 ',
  WARN = '󰀪 ',
  HINT = '󰌶 ',
  INFO = '󰋽 ',
}

--- Shared icons that don't really fit into a category.
M.misc = {
  bug = '',
  git = '',
  palette = '󰏘',
  search = '',
  terminal = '',
  toolbox = '󰦬',
  vertical_bar = '│',
  folder = '󰉋',
  func = '󰊕',
}

return M
