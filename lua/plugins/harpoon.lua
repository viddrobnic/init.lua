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
      vim.keymap.set('n', '<leader>ha', function() harpoon:list():append() end, { desc = '[H]arpoon [a]dd file' })

      vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<C-j>', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<C-k>', function() harpoon:list():select(4) end)
      vim.keymap.set('n', '<C-l>', function() harpoon:list():select(4) end)
    end,
  },
}
