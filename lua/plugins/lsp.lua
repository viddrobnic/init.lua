-- LSP Configuration
local on_attach = function(client, bufnr)
  local opts = function(desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    return { buffer = bufnr, remap = false, desc = desc }
  end

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('[R]e[n]ame'))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts('[C]ode [A]ction'))
  vim.keymap.set({ 'n', 'x' }, 'ff', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, opts('[F]ormat'))

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('[G]oto [D]efinition'))
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts('[G]oto [R]eference'))
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts('[G]oto [I]mplementation'))
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts('Type [D]efinition'))
  vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts('[D]ocument [S]ymbols'))
  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    opts('[W]orkspace [S]ymbols'))

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover Documentation'))
  vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts('Signature Documentation'))

  -- autoformat on save
  require('lsp-zero').buffer_autoformat()
end

return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',             -- Required
    'williamboman/mason.nvim',           -- Optional
    'williamboman/mason-lspconfig.nvim', -- Optional

    -- Autocompletion
    'hrsh7th/nvim-cmp',     -- Required
    'hrsh7th/cmp-nvim-lsp', -- Required
    'L3MON4D3/LuaSnip',     -- Required

    -- Additional rust features
    'simrat39/rust-tools.nvim',

    -- Autocomplete for init.lua
    'folke/neodev.nvim',
  },

  config = function()
    -- Autocomplete for vim stuff
    require('neodev').setup()

    -- LSP setup
    local lsp = require('lsp-zero')
    lsp.preset({
      name = 'recommended',
      suggest_lsp_servers = true,
    })

    lsp.on_attach(on_attach)
    lsp.setup()

    -- Set keymap for autocomplete
    local cmp = require('cmp')
    cmp.setup({
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.config.disable,
        ['<S-Tab>'] = cmp.config.disable,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
      },
    })

    -- Additional rust settings
    require('rust-tools').setup({
      tools = {
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = false,
          parameter_hints_prefix = '',
          other_hints_prefix = '',
        },
      },
      server = {
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              -- always enable all features
              features = 'all',
            },
            -- use clippy on save
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },
    })
  end,
}
