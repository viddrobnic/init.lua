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
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        transparent_mode = true,
        dim_inactive = false,
        terminal_colors = false,
      })

      vim.o.background = "dark"
      vim.cmd.colorscheme 'gruvbox'
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


  -- Fancy undo
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },

  -- Autopairs on newline
  { 'windwp/nvim-autopairs', opts = {} },

  -- Close HTML tags
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  -- Icons
  'nvim-tree/nvim-web-devicons',

  -- Nicer UI
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- Import plugins that require configuration
  { import = 'plugins' }
}, {})
