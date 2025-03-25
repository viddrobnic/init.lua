return {
  -- Highlighting for comments
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
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
}
