return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = "make install_jsregexp",
    },

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local ls = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()

    require('blink.cmp').setup({
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },

      completion = {
        menu = {
          border = 'rounded',

          -- Copy highlight from documentation setting, because gruvbox theme is a bit broken by default.
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',

          draw = {
            columns = {
              { 'label',    'label_description', gap = 1 },
              { 'kind_icon' },
            },
          },
        },

        documentation = {
          auto_show = true,
          window = {
            border = 'rounded'
          },
        },
      },

      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      keymap = {
        preset = 'none',

        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-Space>'] = { 'show' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
    })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
  end
}
