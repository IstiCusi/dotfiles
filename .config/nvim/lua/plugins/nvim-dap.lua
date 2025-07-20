-- return {
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--       -- Adapter für LLDB
--
--       dap.adapters.gdb = {
--         id = 'gdb',
--         type = 'executable',
--         command = '/home/phonon/Development/tools/binutils-gdb/gdb/gdb',
--         args = {'--quiet', '--interpreter=mi2'},
--         options = { initialize_timeout_sec = 10 },
--       }
--       -- Konfiguration für Zig
--       dap.configurations.zig = {
--         {
--           name = "Debug Zig executable",
--           type = "gdb",
--           request = "launch",
--           program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
--           end,
--           cwd = '${workspaceFolder}',
--           stopOnEntry = false,
--           args = {},
--         },
--       }
--       
--       dap.configurations.c = {
--         {
--           name = "Launch C binary",
--           type = "gdb",
--           request = "launch",
--           program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/test_c', 'file')
--           end,
--           cwd = '${workspaceFolder}',
--           stopOnEntry = true,
--           args = {},
--           runInTerminal = true,
--         },
--       }
--
--     end,
--     keys = {
--       { "<leader>Gb", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
--       { "<leader>Gc", function() require("dap").continue() end,         desc = "Debug: Continue" },
--       { "<leader>Go", function() require("dap").step_over() end,        desc = "Debug: Step Over" },
--       { "<leader>Gi", function() require("dap").step_into() end,        desc = "Debug: Step Into" },
--       { "<leader>GO", function() require("dap").step_out() end,         desc = "Debug: Step Out" },
--       { "<leader>Gq", function() require("dap").terminate() end,        desc = "Debug: Quit/Stop" },
--       { "<leader>Gu", function() require("dapui").open() end, desc = "DAP-UI Open" },
--       { "<leader>GU", function() require("dapui").close() end, desc = "DAP-UI Close" },
--
--     }
--   },
--   {
--     "rcarriga/nvim-dap-ui",
--     dependencies = { "mfussenegger/nvim-dap" },
--     config = function()
--       require("dapui").setup()
--       local dap = require("dap")
--       local dapui = require("dapui")
--       dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
--       dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
--       dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
--     end,
--   },
-- }
--



return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Adapter für OpenDebugAD7 (cpptools)
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/home/phonon/Development/tools/OpenDebugAD7/extension/debugAdapters/bin/OpenDebugAD7',
        options = { initialize_timeout_sec = 20 },
      }

      -- GDB-Adapter als Fallback (optional, falls du es weiterhin testen willst)
      dap.adapters.gdb = {
        id = 'gdb',
        type = 'executable',
        command = '/home/phonon/Development/tools/binutils-gdb/gdb/gdb',
        args = {'--quiet', '--interpreter=mi2'},
        options = { initialize_timeout_sec = 10 },
      }

      -- C Konfiguration (über cpptools/OpenDebugAD7)
      dap.configurations.c = {
        {
          name = "Launch C binary (OpenDebugAD7)",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/test_c', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
          args = {},
        },
        -- Optional: als Alternative mit GDB direkt (wenn du willst)
        -- {
        --   name = "Launch C binary (GDB)",
        --   type = "gdb",
        --   request = "launch",
        --   program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/test_c', 'file')
        --   end,
        --   cwd = '${workspaceFolder}',
        --   stopOnEntry = true,
        --   args = {},
        --   runInTerminal = true,
        -- },
      }

      -- Zig einfach als Kopie von C (über OpenDebugAD7)
      dap.configurations.zig = {
        {
          name = "Launch Zig executable (OpenDebugAD7)",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
          args = {},
        },
      }

      -- C++ Konfiguration (für den Fall)
      dap.configurations.cpp = dap.configurations.c

    end,
    keys = {
      { "<leader>Gb", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>Gc", function() require("dap").continue() end,         desc = "Debug: Continue" },
      { "<leader>Go", function() require("dap").step_over() end,        desc = "Debug: Step Over" },
      { "<leader>Gi", function() require("dap").step_into() end,        desc = "Debug: Step Into" },
      { "<leader>GO", function() require("dap").step_out() end,         desc = "Debug: Step Out" },
      { "<leader>Gq", function() require("dap").terminate() end,        desc = "Debug: Quit/Stop" },
      { "<leader>Gu", function() require("dapui").open() end,           desc = "DAP-UI Open" },
      { "<leader>GU", function() require("dapui").close() end,          desc = "DAP-UI Close" },
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}




