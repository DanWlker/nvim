-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
local function handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'VimEnter',
  keys = {
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    {
      'zR',
      function() require('ufo').openAllFolds() end,
    },
    {
      'zM',
      function() require('ufo').closeAllFolds() end,
    },
  },
  init = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    fold_virt_text_handler = handler,
    provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end,
    -- To fix missing required fields:
    -- open_fold_hl_timeout = 400,
    -- close_fold_kinds_for_ft = { default = {} },
    -- enable_get_fold_virt_text = false,
    -- preview = {
    --   win_config = {
    --     border = 'rounded',
    --     winblend = 12,
    --     winhighlight = 'Normal:Normal',
    --     maxheight = 20,
    --   },
    --   mappings = {},
    -- },
  },
}
