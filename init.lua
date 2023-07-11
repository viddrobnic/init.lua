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

require('lazy').setup({
  -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end
  },

  -- NOTE: First some plugins that don't require configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Show errors inline
  'folke/trouble.nvim',

  -- Show which keybindgs are available with
  { 'folke/which-key.nvim',  opts = {} },

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
  { 'numToStr/Comment.nvim', opts = {} },

  -- Buffer managment
  'jlanzarotta/bufexplorer',

  -- Import plugins that require configuration
  { import = 'plugins' }
}, {})
