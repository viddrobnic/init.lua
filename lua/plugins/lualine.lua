-- Status line
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'f-person/git-blame.nvim',
  },
  config = function()
    local git_blame = require('gitblame')
    vim.g.gitblame_display_virtual_text = 0
    vim.g.gitblame_date_format = '%r'
    vim.g.gitblame_message_template = '<author> • <date>'


    require('lualine').setup({
      options = {
        theme = 'auto',
        icons_enabled = true,
      },
      sections = {
        lualine_b = { 'diagnostics' },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1,
          },
        },
        lualine_x = {
          {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available,
            separator = '',
            padding = 1,
            color = { fg = '#6e738d' },
          },
          {
            function()
              if vim.bo.expandtab then
                return '󱁐'
              else
                return ''
              end
            end,
            padding = 2,
          },
          'filetype',
        },
      },
    })
  end
}
