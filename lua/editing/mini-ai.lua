-- Everything in here is from LazyVim
return {
  'nvim-mini/mini.ai',
  event = 'VimEnter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local ai = require('mini.ai')
    local miniextra = require('mini.extra')

    local opts = {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
        d = miniextra.gen_ai_spec.number(),
        e = { -- Word with case
          {
            '%u[%l%d]+%f[^%l%d]',
            '%f[%S][%l%d]+%f[^%l%d]',
            '%f[%P][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
          },
          '^().*()$',
        },
        g = miniextra.gen_ai_spec.buffer(), -- buffer
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
        l = miniextra.gen_ai_spec.line(),
      },
      mappings = {
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
      },
    }

    ai.setup(opts)

    local function ai_whichkey(wopts)
      local ok, module = pcall(function() return require('which-key') end)
      if not ok then return end

      local objects = {
        { ' ', desc = 'whitespace' },
        { '"', desc = '" string' },
        { "'", desc = "' string" },
        { '(', desc = '() block' },
        { ')', desc = '() block with ws' },
        { '<', desc = '<> block' },
        { '>', desc = '<> block with ws' },
        { '?', desc = 'user prompt' },
        { 'U', desc = 'use/call without dot' },
        { '[', desc = '[] block' },
        { ']', desc = '[] block with ws' },
        { '_', desc = 'underscore' },
        { '`', desc = '` string' },
        { 'a', desc = 'argument' },
        { 'b', desc = ')]} block' },
        { 'c', desc = 'class' },
        { 'd', desc = 'digit(s)' },
        { 'e', desc = 'CamelCase / snake_case' },
        { 'f', desc = 'function' },
        { 'g', desc = 'entire file' },
        { 'o', desc = 'block, conditional, loop' },
        { 'q', desc = 'quote `"\'' },
        { 't', desc = 'tag' },
        { 'l', desc = 'line' },
        { 'u', desc = 'use/call' },
        { '{', desc = '{} block' },
        { '}', desc = '{} with ws' },
      }

      local ret = { mode = { 'o', 'x' } }
      ---@type table<string, string>
      local mappings = vim.tbl_extend('force', {}, {
        around = 'a',
        inside = 'i',
        -- around_next = 'an',
        -- inside_next = 'in',
        -- around_last = 'al',
        -- inside_last = 'il',
      }, wopts.mappings or {})
      mappings.goto_left = nil
      mappings.goto_right = nil

      for name, prefix in pairs(mappings) do
        if prefix == '' then goto continue end
        name = name:gsub('^around_', ''):gsub('^inside_', '')
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          local desc = obj.desc
          if prefix:sub(1, 1) == 'i' then desc = desc:gsub(' with ws', '') end
          ret[#ret + 1] = { prefix .. obj[1], desc = desc }
        end
        ::continue::
      end

      module.add(ret, { notify = false })
    end
    ai_whichkey(opts)
  end,
}
