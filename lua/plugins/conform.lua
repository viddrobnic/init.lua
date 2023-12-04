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
        markdown = { 'mdformat' },
        html = { 'djlint', 'rustywind' },
        javascript = { 'prettierd', 'rustywind' },
        javascriptreact = { 'prettierd', 'rustywind' },
        typescript = { 'prettierd', 'rustywind' },
        typescriptreact = { 'prettierd', 'rustywind' },
      },

      format_on_save = opts,
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      conform.format(opts)
    end, { desc = '[F]ormat' })
  end,
}
