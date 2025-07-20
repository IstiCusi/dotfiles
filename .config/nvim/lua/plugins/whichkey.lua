return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
  --   defaults = {
  -- ["<leader>f"] = { name = "+find" },
  -- ["<leader>t"] = { name = "+tabs" },
  -- ["<leader>tt"] = { name = "open terminal" }, -- wenn nötig
  -- ["<leader>n"] = { name = "+toggle" },
  -- ["<leader>e"] = { name = "+explorer" },
  -- ["<leader>w"] = { name = "+session" },
  -- ["<leader>h"] = { name = "+git" },
  -- ["<leader>s"] = { name = "+substitute" },
  -- ["<leader>x"] = { name = "+trouble" },
  -- ["<leader>c"] = { name = "+correct" },
  -- ["<leader>r"] = { name = "+refactor" },
  -- ["<leader>S"] = { name = "+surround" },
  -- ["<leader>o"] = { name = "+neorg" },
  -- ["<leader>cp"] = { name = "toggle copilot" }, -- optional
-- }
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
