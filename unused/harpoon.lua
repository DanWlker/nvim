return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        '<leader>m',
        function() require('harpoon'):list():add() end,
        desc = 'Mark Harpoon',
      },
      {
        '<leader>M',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list(), { border = 'rounded' })
        end,
        desc = 'Menu Harpoon',
      },
    }
    local str = 'haef'
    for i = 1, #str do
      table.insert(keys, {
        '<C-' .. str:sub(i, i) .. '>',
        function() require('harpoon'):list():select(i) end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    -- for i = 1, 5 do
    --   table.insert(keys, {
    --     '<leader>' .. i,
    --     function()
    --       require('harpoon'):list():select(i)
    --     end,
    --     desc = 'Harpoon to File ' .. i,
    --   })
    -- end
    return keys
  end,
}
