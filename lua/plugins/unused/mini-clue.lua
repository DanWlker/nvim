local function ai_clue()
  local objects = {
    { ' ', desc = 'whitespace' },
    { '"', desc = '" string' },
    { "'", desc = "' string" },
    { '(', desc = '() block' },
    { ')', desc = '() block with ws' },
    { '<', desc = '<> block' },
    { '>', desc = '<> block with ws' },
    { '?', desc = 'user prompt' },
    { '[', desc = '[] block' },
    { ']', desc = '[] block with ws' },
    { '_', desc = 'underscore' },
    { '`', desc = '` string' },
    { 'a', desc = 'argument' },
    { 'b', desc = ')]} block' },
    { 'B', desc = '[{]} block' },
    { 'c', desc = 'class' },
    { 'd', desc = 'digit(s)' },
    { 'e', desc = 'CamelCase / snake_case' },
    { 'f', desc = 'function' },
    { 'g', desc = 'entire file' },
    { 'o', desc = 'block, conditional, loop' },
    { 'p', desc = 'paragraph' },
    { 'q', desc = 'quote `"\'' },
    { 's', desc = 'sentence' },
    { 't', desc = 'tag' },
    { 'l', desc = 'line' },
    { 'u', desc = 'use/call' },
    { 'U', desc = 'use/call without dot' },
    { 'w', desc = 'word with ws' },
    { 'W', desc = 'WORD with ws' },
    { '{', desc = '{} block' },
    { '}', desc = '{} with ws' },
  }

  local modes = { 'x', 'o' }
  local ret = {}
  ---@type table<string, string>
  local mappings = {
    around = 'a',
    inside = 'i',
    -- around_next = 'an',
    -- inside_next = 'in',
    -- around_last = 'al',
    -- inside_last = 'il',
  }

  -- print(vim.inspect(mappings))

  for _, prefix in pairs(mappings) do
    if prefix == '' then goto continue end
    for _, mode in ipairs(modes) do
      for _, obj in ipairs(objects) do
        local desc = obj.desc
        if prefix:sub(1, 1) == 'i' then desc = desc:gsub(' with ws', '') end
        ret[#ret + 1] = { mode = mode, keys = prefix .. obj[1], desc = desc }
      end
    end
    ::continue::
  end

  return ret
end

return {
  'nvim-mini/mini.clue',
  config = function()
    local miniclue = require('mini.clue')
    miniclue.setup({
      window = {
        delay = 500,
        config = {
          border = 'rounded',
          width = 'auto',
        },
        scroll_down = '',
        scroll_up = '',
      },
      clues = {
        {
          { keys = '<leader>x', desc = 'Trouble' },
          { keys = '<leader>f', desc = '[F]ind' },
          { keys = '<leader>w', desc = '[W]orkspace' },
          { keys = '<leader>g', desc = '[G]it' },
          { keys = '<leader>t', desc = '[T]oggle' },
          { keys = 'gr', desc = 'LSP Actions', mode = { 'n' } },
        },
        ai_clue(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows({ submode_resize = true }),
        miniclue.gen_clues.z(),
      },
      -- Explicitly opt-in for set of common keys to trigger clue window
      triggers = {
        { mode = 'n', keys = '<Leader>' }, -- Leader triggers
        { mode = 'x', keys = '<Leader>' },
        { mode = 'n', keys = '[' }, -- mini.bracketed
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = '[' },
        { mode = 'x', keys = ']' },
        { mode = 'n', keys = 'g' }, -- `g` key
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" }, -- Marks
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' }, -- Registers
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' }, -- Window commands
        { mode = 'n', keys = 'z' }, -- `z` key
        { mode = 'x', keys = 'z' },
        { mode = 'n', keys = 'j' }, -- `g` key
        { mode = 'x', keys = 'j' },

        { mode = 'x', keys = 'a' },
        { mode = 'o', keys = 'a' },
        { mode = 'x', keys = 'i' },
        { mode = 'o', keys = 'i' },
      },
    })
  end,
}
