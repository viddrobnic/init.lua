return {
  'stevearc/conform.nvim',
  config = function()
    local opts = {
      lsp_fallback = true,
      timeout_ms = 1000,
      notify_on_error = true,
    }

    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        markdown = { 'prettier' },
        html = { 'djlint', 'rustywind' },
        javascript = { 'prettier', 'rustywind' },
        javascriptreact = { 'prettier', 'rustywind' },
        typescript = { 'prettier', 'rustywind' },
        typescriptreact = { 'prettier', 'rustywind' },
        yaml = { 'prettier' },
      },

      format_on_save = opts,
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      conform.format(opts)
    end, { desc = '[F]ormat' })
  end,
}
