return {
  'nvim-mini/mini.indentscope',
  config = function()
    local indentscope = require('mini.indentscope')
    indentscope.setup({
      draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
      },
      options = {
        try_as_border = true,
      },
      -- symbol = '│',
      symbol = '▏',
    })
  end,
}
