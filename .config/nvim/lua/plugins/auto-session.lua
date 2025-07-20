return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      root_dir = vim.fn.stdpath('config') .. "/sessions/",
      auto_restore = false,
      auto_save = false,
      suppressed_dirs = { "~/Downloads" },
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
    })


    Phonon.autoSession()
  end,
}


