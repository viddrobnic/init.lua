-- Copilot, obviously :)
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
        },
      },
      filetypes = {
        yaml = true,
      },
    })

    vim.keymap.set('i', '<Tab>', function()
      if require('copilot.suggestion').is_visible() then
        require('copilot.suggestion').accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end
    end, {
      silent = true,
    })
  end
}
