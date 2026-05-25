return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'igorlfs/nvim-dap-view',
  },
  config = function()
    local dap = require('dap')

    require('nvim-dap-virtual-text').setup()

    local ui = require('dap-view')
    ui.setup({
      winbar = {
        controls = {
          enabled = true,
        },
      },
    })
    -- require("nvim-dap-virtual-text").setup()

    vim.keymap.set("n", "<leader>dr", function()
      vim.cmd.RustLsp("debuggables")
    end, { desc = "Rust debuggables" })

    vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

    vim.keymap.set("n", "<F1>", dap.continue)
    vim.keymap.set("n", "<F2>", dap.step_into)
    vim.keymap.set("n", "<F3>", dap.step_over)
    vim.keymap.set("n", "<F4>", dap.step_out)
    vim.keymap.set("n", "<F5>", dap.step_back)
    vim.keymap.set("n", "<leader>dt", dap.terminate)

    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
    }

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
