return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  config = function()
    -- Suggestions are managed with cmp
    require('copilot').setup({
      panel = { enabled = false },
      suggestions = { enabled = false },
    })
  end
}
