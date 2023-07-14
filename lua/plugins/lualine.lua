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
        theme = 'catppuccin-macchiato',
        icons_enabled = true,
      },
      sections = {
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
            padding = 3,
            color = { fg = '#6e738d' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    })
  end
}
