return {
  "kylechui/nvim-surround",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup({
      -- keymaps = {
      --   insert = "<leader>S",           -- Surround in Insert mode
      --   insert_line = "<leader>SS",     -- Surround entire line in Insert mode
      --   normal = "<leader>S",           -- Surround in Normal mode
      --   normal_cur = "<leader>SC",      -- Surround current line/selection in Normal mode
      --   visual = "<leader>SV",          -- Surround in Visual mode
      --   visual_line = "<leader>SL",     -- Surround entire line in Visual mode
      --   delete = "<leader>SD",          -- Delete surround
      --   change = "<leader>SC",          -- Change surround
      -- }
      keymaps = Phonon.surroundKeys
      -- Other configurations remain the same
    })
  end,
}
