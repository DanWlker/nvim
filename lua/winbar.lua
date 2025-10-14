local folder_icon = require('icons').misc.folder
local function escape_pattern(text) return text:gsub('([^%w])', '%%%1') end

local M = {}

--- Window bar that shows the current file path (in a fancy way).
---@return string
function M.render()
  -- Get the path and expand variables.
  local path = vim.fs.normalize(vim.fn.expand('%:p') --[[@as string]])

  -- No special styling for diff views.
  if vim.startswith(path, 'diffview') then
    return string.format('%%#Winbar#%s', path)
  end

  -- Replace slashes by arrows.
  local separator = ' %#WinbarSeparator# '

  local prefix, prefix_path = '', ''

  -- For some special folders, add a prefix instead of the full path (making
  -- sure to pick the longest prefix).
  ---@type table<string, string>
  local special_dirs = {
    HOME = vim.env.HOME,
    XDG_CONFIG = vim.env.XDG_CONFIG_HOME,
    DOTFILES = vim.env.HOME .. '/.dotfiles',
    PROJECTS = vim.env.HOME .. '/projects',
    CWD = vim.uv.cwd() or '',
  }
  for dir_name, dir_path in pairs(special_dirs) do
    if dir_path == '' then goto continue end
    if
      vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path
    then
      prefix, prefix_path = dir_name, dir_path
    end
    ::continue::
  end
  if prefix ~= '' then
    path = path:gsub('^' .. escape_pattern(prefix_path), '')
    prefix = string.format('%%#WinBarDir#%s %s%s', folder_icon, prefix, separator)
  end
  -- If the window gets too narrow, shorten the path
  if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
    path = vim.fn.pathshorten(path)
  end

  -- Remove leading slash.
  path = path:gsub('^/', '')
  -- return table.concat {
  --   ' ',
  --   prefix,
  --   table.concat(
  --     vim
  --       .iter(vim.split(path, '/'))
  --       :map(function(segment)
  --         return string.format('%%#Winbar#%s', segment)
  --       end)
  --       :totable(),
  --     separator
  --   ),
  -- }

  return table.concat({
    -- '%=',
    -- '%#WinBarEndSeparators#',
    '%#WinBarIndDir# ',
    prefix,
    table.concat(
      vim
        .iter(vim.split(path, '/'))
        :map(function(segment)
          -- return string.format('%%#Winbar#%s', segment)
          return string.format('%%#WinBarIndDir#%s', segment)
        end)
        :totable(),
      separator
    ),
    '%#WinBarIndDir# ',
    -- '%#WinBarEndSeparators#',
    '%=',
  })
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  -- Thanks Maria <3
  group = vim.api.nvim_create_augroup('danwlker/winbar', { clear = true }),
  desc = 'Attach winbar',
  callback = function(args)
    if
      not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
      and vim.bo[args.buf].buftype == '' -- Normal buffer
      and vim.api.nvim_buf_get_name(args.buf) ~= '' -- Has a file name
      and not vim.wo[0].diff -- Not in diff mode
    then
      vim.wo.winbar = "%{%v:lua.require'personal.winbar'.render()%}"
    end
  end,
})

return M
