-- LSP Configuration
local on_attach = function(client, bufnr)
  local opts = function(desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    return { buffer = bufnr, remap = false, desc = desc }
  end

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('[R]e[n]ame'))
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts('[C]ode [A]ction'))

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('[G]oto [D]efinition'))
  vim.keymap.set('n', '<leader>gd', function()
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('wincmd l')
    vim.lsp.buf.definition()
  end, opts('[G]oto [D]efinition [Split]'))
  vim.keymap.set('n', 'grr', require('telescope.builtin').lsp_references, opts('[G]oto [R]eference'))
  vim.keymap.set('n', 'gri', require('telescope.builtin').lsp_implementations, opts('[G]oto [I]mplementation'))
  vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, opts('[D]ocument [S]ymbols'))
  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    opts('[W]orkspace [S]ymbols'))

  vim.keymap.set('n', 'gh', function()
      vim.lsp.buf.hover({ border = 'rounded' })
    end,
    opts('Hover Documentation'))
  vim.keymap.set('i', '<C-k>', function()
      vim.lsp.buf.signature_help({ border = 'rounded' })
    end,
    opts('Signature Documentation'))

  vim.lsp.inlay_hint.enable(true)

  -- Document highlighting
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Additional rust features
    {
      'mrcjkb/rustaceanvim',
      version = '^6', -- Recommended
    },

    -- Autocomplete for neovim api
    'folke/neodev.nvim',

    -- Useful status updates for LSP
    {
      'j-hui/fidget.nvim',
      opts = {},
    },

    'saghen/blink.cmp',
  },

  config = function()
    local servers = {
      clangd = {},
      cmake = {},
      gopls = {
        gopls = {
          hints = {
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true
          },
          usePlaceholders = true,
        },
      },
      golangci_lint_ls = {},
      pyright = {},
      ruff = {},
      vtsls = {},
      eslint = {},
      html = {},
      cssls = {},
      tailwindcss = {},
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
      zls = {
        manual_install = true,
        zls = {
          enable_build_on_save = true,
        },
      },

      nushell = {
        manual_install = true,
      },
    }

    require('mason').setup()
    require('mason-lspconfig').setup()
    require('neodev').setup()

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local lspconfig = require('lspconfig')

    -- Ensure the servers above are installed
    local ensure_installed = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    -- Configure the servers with lspconfig
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach,
      }, config)

      lspconfig[name].setup(config)
    end

    -- Rust setup
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = 'rounded',
        },
      },
      server = {
        on_attach = on_attach,
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              -- always enable all features
              features = 'all',
            },
            -- use clippy on save
            checkOnSave = true,
            check = {
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
          },
        },
      }
    }
  end,
}
