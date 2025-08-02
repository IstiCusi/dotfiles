return {
  "kylechui/nvim-surround",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    require("nvim-surround").setup({
      keymaps = Phonon.surroundKeys
    })
  end,
}
