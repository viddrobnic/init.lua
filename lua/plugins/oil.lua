return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({
      view_options = {
        show_hidden = true
      }
    })

    vim.keymap.set('n', '<leader>ex', function()
      oil.open()
    end)
  end
}
