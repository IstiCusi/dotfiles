return {
  lazy=false,
  dir = "~/.config/nvim/scripts/clective",
  name = "clective",
  keys = {
    { "<leader>Kc", function() require("clective").select_config() end, desc = "Select clective include config" },
  },
  config = function()
    require("clective").setup({
      profiles = {
        ["amiga-c"] = {
          "/home/phonon/Development/codesnips/amiga/include",
        }
      }
    })
  end,
}
