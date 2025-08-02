
return {
  "vimwiki/vimwiki",
  init = function()
    -- Konfiguration muss hier gesetzt werden, bevor das Plugin geladen wird
    vim.g.vimwiki_list = {
      {
        path = vim.fn.expand("~/Development/vimwikineo/"),
        syntax = "default",
        ext = ".wiki",
        links_space_char = " ",  -- Leerzeichen in Links statt Unterstrich
      },
    }
    vim.g.vimwiki_ext2syntax = {
      wiki = "default",
    }

    -- Optional: Tagebuch-Syntax (wenn du diary-Funktion nutzt)
    -- vim.g.vimwiki_diary_rel_path = "diary/"
    -- vim.g.vimwiki_diary_index = "diary"
    -- vim.g.vimwiki_auto_diary_index = 1
  end,
  keys = {
    { "<leader>ow", "<cmd>VimwikiIndex<CR>", desc = "Open VimWiki index" },
    -- { "<leader>ww", "<cmd>VimwikiMakeDiaryNote<CR>", desc = "VimWiki diary note" },
    -- { "<leader>wt", "<cmd>VimwikiTabIndex<CR>", desc = "VimWiki tab index" },
  },
  ft = { "wiki" },
}
