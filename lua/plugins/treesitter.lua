-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-refactor',
  },
  config = function()
    -- Configure treesitter
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'c',
        'cpp',
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
      },

      auto_install = false,

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
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          node_decremental = '<C-Bslash>',
          scope_incremental = false,
        },
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
        },
      },
    }
  end,
}
