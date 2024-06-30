return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set('n', '<leader>he', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = '[H]arpoon toggle m[e]nu' })
      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon [a]dd file' })

      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)
      vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end)
    end,
  },
}
