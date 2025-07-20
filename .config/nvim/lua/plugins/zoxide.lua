-- Datei: ~/.config/nvim/lua/plugins/nvim-zoxide.lua
return {
  {
    "alfaix/nvim-zoxide",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      define_commands = true,    -- erzeugt :Z, :Zt, :Zw Befehle
      path = "zoxide",           -- Pfad zur zoxide‑Binärdatei
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = { zoxide = {} },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("zoxide")
    end,
  }
}

