return {
  'stevearc/conform.nvim',
  config = function()
    local opts = {
      lsp_format = 'first',
      timeout_ms = 1000,
      notify_on_error = true,
    }

    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        markdown = { 'prettierd' },
        html = { 'prettierd' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        astro = { 'prettierd' },
      },

      format_on_save = function()
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat then
          return
        end
        return opts
      end,
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      conform.format(opts)
    end, { desc = '[F]ormat' })

    vim.api.nvim_create_user_command("FormatDisable", function()
      vim.g.disable_autoformat = true
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
