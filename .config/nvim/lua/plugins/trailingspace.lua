return {
  "echasnovski/mini.trailspace",
  event = "BufReadPre",
  config = function()
    require("mini.trailspace").setup()
  end,
}

