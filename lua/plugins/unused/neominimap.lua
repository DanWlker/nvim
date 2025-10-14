return {
  'Isrothy/neominimap.nvim',
  version = 'v3.*.*',
  event = 'VimEnter',
  init = function()
    -- The following options are recommended when layout == "float"
    vim.o.wrap = false
    vim.o.sidescrolloff = 20 -- Set a large value

    vim.g.neominimap = {
      auto_enable = true,
      git = { enabled = false },
      search = { enabled = true },
      buf_filter = function(bufnr)
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        return line_count < 4096
      end,
      float = {
        z_index = 21, -- must be higher than treesitter context
        window_border = 'none',
        -- readd margin if use incline nvim
        -- margin = {
        --   top = 2,
        -- },
        minimap_width = 12,
      },
      click = {
        enabled = true,
      },
      exclude_filetypes = {
        'help',
        'dbout',
      },
      winopt = function(wo) wo.cursorlineopt = 'line' end,
    }
  end,
}
