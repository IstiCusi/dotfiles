return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_session_root_dir = vim.fn.stdpath('config').."/sessions/",
      auto_restore_enabled = false,  -- keine automatische Wiederherstellung
      auto_save_enabled = false,     -- IMPORTANT, without that -> troubles 
      auto_session_suppress_dirs = { "~/Downloads" },
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    })

    Phonon.autoSession()
  end,
}

