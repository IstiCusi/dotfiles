return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("substitute").setup({
      range = { prefix = "g" }
    })

    -- Lade alle Mappings aus dem globalen Phonon-Container!
    local substitute = require("substitute")
    for _, km in ipairs(Phonon.substitute_keymaps) do
      local mode, lhs, func_name, desc = km[1], km[2], km[3], km[4]
      vim.keymap.set(
        mode,
        lhs,
        substitute[func_name],
        { desc = desc }
      )
    end
  end,
}

