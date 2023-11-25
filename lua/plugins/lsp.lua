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
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, opts('[G]oto [I]mplementation'))
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts('Type [D]efinition'))
  vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts('[D]ocument [S]ymbols'))
  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    opts('[W]orkspace [S]ymbols'))

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover Documentation'))
  vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts('Signature Documentation'))

  -- command to autoformat and save
  vim.keymap.set('n', 'fw', function()
    if client.supports_method("textDocument/formatting") then
      vim.lsp.buf.format()
      vim.cmd('write')
    end
  end, opts('[F]ormat on [W]rite'))
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Additional rust features
    'simrat39/rust-tools.nvim',

    -- Additional go features
    'fatih/vim-go',

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },

    -- Autocomplete for init.lua
    'folke/neodev.nvim',

    -- JS prettier
    'prettier/vim-prettier',
  },

  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()

    local servers = {
      clangd = {},
      gopls = {},
      golangci_lint_ls = {},
      marksman = {},
      pyright = {},
      tsserver = {},
      eslint = {},
      html = {},
      templ = {},
      tailwindcss = {
        filetypes = {
          'html',
          'css',
          'scss',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'templ',
        },
        init_options = {
          userLanguages = {
            templ = 'html',
          },
        },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      jsonls = {},
      yamlls = {},
      spectral = {},
      taplo = {},
    }

    -- Autocomplete for vim stuff
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
          init_options = (servers[server_name] or {}).init_options,
        }
      end,
    }

    -- Custom signs for diagnostics
    vim.fn.sign_define('DiagnosticSignError', { text = '✘', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '▲', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '⚑', texthl = 'DiagnosticSignHint' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '»', texthl = 'DiagnosticSignInfo' })

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
