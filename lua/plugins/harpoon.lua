return {
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local term = require 'harpoon.term'
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[H]arpoon [a]dd file' })
      vim.keymap.set('n', '<leader>hr', mark.rm_file, { desc = '[H]arpoon [r]emove file' })
      vim.keymap.set('n', '<leader>he', ui.toggle_quick_menu, { desc = '[H]arpoon toggle m[e]nu' })

      -- open terminal
      vim.keymap.set('n', '<leader>ht', function()
        term.gotoTerminal(0)
      end, { desc = '[H]arpoon [t]erminal' })
    end,
  },
}
