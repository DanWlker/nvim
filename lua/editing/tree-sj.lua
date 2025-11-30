return {
  'Wansmer/treesj',
  keys = {
    { 'jt', desc = 'Toggle Join/Split with treesitter' },
    { 'js', desc = 'Split with treesitter' },
    { 'jj', desc = 'Join with treesitter' },
  },
  config = function()
    local treesj = require('treesj')
    treesj.setup({ use_default_keymaps = false })
    local tsj_langs = require('treesj.langs')['presets']

    local function get_pos_lang()
      local c = vim.api.nvim_win_get_cursor(0)
      local range = { c[1] - 1, c[2], c[1] - 1, c[2] }
      local buf = vim.api.nvim_get_current_buf()
      local ok, parser = pcall(
        vim.treesitter.get_parser,
        buf,
        vim.treesitter.language.get_lang(vim.bo[buf].ft)
      )
      if not ok or parser == nil then return '' end
      return parser:language_for_range(range):lang()
    end

    vim.keymap.set('n', 'jt', function()
      local lang = get_pos_lang()
      if lang ~= '' and tsj_langs[lang] then
        treesj.toggle()
      else
        require('mini.splitjoin').toggle() -- lazy load, only load if need to fallback
      end
    end)

    vim.keymap.set('n', 'js', function()
      local lang = get_pos_lang()
      if lang ~= '' and tsj_langs[lang] then
        treesj.split()
      else
        require('mini.splitjoin').split() -- lazy load, only load if need to fallback
      end
    end)

    vim.keymap.set('n', 'jj', function()
      local lang = get_pos_lang()
      if lang ~= '' and tsj_langs[lang] then
        treesj.join()
      else
        require('mini.splitjoin').join() -- lazy load, only load if need to fallback
      end
    end)
  end,
}
