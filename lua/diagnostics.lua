vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
  end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
  end,
  { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.diagnostic.config {
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
}
