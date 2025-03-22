-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',

    -- detect comments with different language from file (ie jsx)
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'go',
          'lua',
          'python',
          'rust',
          'tsx',
          'typescript',
          'vimdoc',
          'vim',
          'bash',
          'javascript',
          'markdown',
          'markdown_inline',
          'sql',
          'nu',
        },
        sync_install = false,
        auto_install = false,

        ignore_install = {},

        context_commentstring = {
          enable = true,
        },

        modules = {},

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '[x',
            node_incremental = '[x',
            node_decremental = ']x',
            scope_incremental = false,
          },
        },
      })
    end, 0)
  end,
}
