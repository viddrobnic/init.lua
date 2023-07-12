-- LSP Configuration
local on_attach = function(_, bufnr)
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
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, opts('[G]oto [I]mplementation'))
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
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    -- Additional rust features
    'simrat39/rust-tools.nvim',

    -- Additional go features
    'ray-x/go.nvim',

    -- Autocomplete for init.lua
    'folke/neodev.nvim',
    u },

  config = function()
    -- Autocomplete for vim stuff
    require('neodev').setup()

    -- LSP setup
    local lsp = require('lsp-zero')
    lsp.preset({
      name = 'recommended',
    })

    lsp.on_attach(on_attach)

    lsp.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    })

    -- Skip rust server setup, we will do it later.
    lsp.skip_server_setup({ 'rust_analyzer' })

    lsp.setup()

    -- Set keymap for autocomplete
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.config.disable,
        ['<S-Tab>'] = cmp.config.disable,
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    })

    -- Additional go settings
    require('go').setup()

    -- Additional rust settings
    local rust_tools = require('rust-tools')
    rust_tools.setup({
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
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>rh', rust_tools.hover_actions.hover_actions,
            { buffer = bufnr, desc = 'LSP: [R]ust [H]over' })
        end,
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
