return {
  'nvim-mini/mini.move',
  event = 'ModeChanged *:[vV\22]', -- only using it in visual mode for now
  opts = {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<',
      right = '>',
      down = '<S-Down>',
      up = '<S-Up>',

      -- Move current line in Normal mode
      line_left = '',
      line_right = '',
      line_down = '',
      line_up = '',
    },
  },
}
