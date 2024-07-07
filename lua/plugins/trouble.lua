-- Show inline diagnostics and a nice list of errors
return {
  'folke/trouble.nvim',
  config = function()
    require("trouble").setup({})

    vim.keymap.set('n', '<leader>tt', function()
      require("trouble").toggle('diagnostics')
    end)
  end
}
