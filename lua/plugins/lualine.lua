-- Status line
return {
  'nvim-lualine/lualine.nvim',
  opts = {
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
      }
    }
  }
}
