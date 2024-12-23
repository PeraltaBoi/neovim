return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Configure DAP for C#
      dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/local/bin/netcoredbg/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      -- Configure DAPUI
      dapui.setup()

      -- Auto open/close dapui
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      -- Set up keymaps
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end)
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end)
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end)
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end)
      vim.keymap.set('n', '<Leader>b', function()
        dap.toggle_breakpoint()
      end)
    end,
  },
}
