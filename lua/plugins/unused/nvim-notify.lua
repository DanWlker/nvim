return {
  'rcarriga/nvim-notify',
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(msg, level, opts) require('notify')(msg, level, opts) end
  end,
  opts = {
    fps = 120, --remove this if hit issues
    timeout = 3000,
  },
}
