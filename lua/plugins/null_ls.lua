-- LSP formatting and diagnostics
return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jay-babu/mason-null-ls.nvim',

    -- After lsp-zero
    'VonHeikemen/lsp-zero.nvim',
  },
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup {
      sources = {
        -- python
        null_ls.builtins.formatting.autopep8,
        -- typescript
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.rustywind,
        -- json
      },
    }

    -- Easier managment of tools required to run null_ls
    require('mason-null-ls').setup()
  end,
}
