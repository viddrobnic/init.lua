-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- Setup additional telescope options
    require('telescope').setup({
      pickers = {
        find_files = {
          find_command = {
            'rg',
            '--files',
            '--color', 'never',
            '--hidden',
            '--smart-case',
            '-g', '!.git',
          },
        },
      },
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color', 'never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '-g', '!.git',
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- Set keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  end
}
