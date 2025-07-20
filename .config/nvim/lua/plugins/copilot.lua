return {
  -- Copilot Plugin (standardmäßig deaktiviert)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Nur diese Warnung unterdrücken
      local orig_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == "string"
            and msg:match("%[Copilot%.lua%] copilot is disabled") then
          return
        end
        return orig_notify(msg, level, opts)
      end

      -- Anfangsstatus global deaktiviert
      vim.g.copilot_enabled = false

      require("copilot").setup({
        panel = {
          enabled = true,        -- Panel ist konfiguriert, aber Copilot tut nichts
          auto_refresh = true,
          keymap = {
            jump_prev = "<C-A-k>",
            jump_next = "<C-A-j>",
            accept     = "<C-A-CR>",
            refresh    = "<C-A-r>",
            open       = "<C-A-o>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,       -- Vorschläge deaktiviert (standard)
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-A-a>",
            next = "<C-A-j>",
            prev = "<C-A-k>",
            dismiss = "<C-A-x>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
          ["*"] = false,  -- Fängt alle sonstigen Dateitypen ab
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })

      -- Status-Monitoring für lualine
      vim.defer_fn(function()
        local ok, api = pcall(require, "copilot.api")
        if ok and api and api.register_status_notification_handler then
          api.register_status_notification_handler(function(data)
            vim.g.copilot_enabled = data.status == "Normal"
            vim.cmd("redrawstatus")
          end)
        end
      end, 100)
    end,
  },

  -- Copilot + cmp
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

