return {
  'nvim-mini/mini.icons',
  version = false,
  lazy = true,
  config = function()
    require('mini.icons').setup({
      -- Check last letters explicitly to account for dots in file name
      use_file_extension = function(ext)
        return ext:sub(-3) ~= 'scm'
          or ext:sub(-3) ~= 'yml'
          or ext:sub(-3) ~= 'json'
          or ext:sub(-3) ~= 'txt'
      end,
    })
    MiniIcons.mock_nvim_web_devicons()
  end,
}
