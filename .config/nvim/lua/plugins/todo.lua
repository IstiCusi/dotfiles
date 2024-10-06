return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  signs = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup({
      signs = true, -- show icons in the sign column
      keywords = {
        MARK = { icon = "☢", color = "info" }, -- add custom REMARK keyword
      },
    })
    -- todo_comments.setup()
  end,
}
