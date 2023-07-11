-- LSP formatting, diagnostics, ...
return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- python
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.ruff,
        -- typescript
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
        -- golang
        null_ls.builtins.diagnostics.golangci_lint,
      },
    }
  end,
}
