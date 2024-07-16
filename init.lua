require('set')
require('remap')


-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Needs to be set globally for the ts context string
-- extension to work correctly
vim.g.skip_ts_context_commentstring_module = true

require('lazy').setup({
  -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
    end
  },

  -- NOTE: First some plugins that don't require configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Autopairs on newline
  { 'windwp/nvim-autopairs', opts = {} },

  -- Highlighting for comments
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  -- Fancy undo
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },

  -- Comment block of lines
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },

  -- Close HTML tags
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  -- Supermaven
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup({
        log_level = 'off',
      })
      local api = require('supermaven-nvim.api')

      api.stop()

      vim.keymap.set('n', '<leader>sm', api.toggle)
    end,
  },

  -- Icons
  'nvim-tree/nvim-web-devicons',

  -- Import plugins that require configuration
  { import = 'plugins' }
}, {})
