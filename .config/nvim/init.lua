---        ▛▀▖▌              ▝▌   ▙ ▌         ▗      ▞▀▖   ▐
---        ▙▄▘▛▀▖▞▀▖▛▀▖▞▀▖▛▀▖▝▞▀▘ ▌▌▌▞▀▖▞▀▖▌ ▌▄ ▛▚▀▖ ▚▄ ▞▀▖▜▀ ▌ ▌▛▀▖
---        ▌  ▌ ▌▌ ▌▌ ▌▌ ▌▌ ▌ ▝▀▖ ▌▝▌▛▀ ▌ ▌▐▐ ▐ ▌▐ ▌ ▖ ▌▛▀ ▐ ▖▌ ▌▙▄▘
---        ▘  ▘ ▘▝▀ ▘ ▘▝▀ ▘ ▘ ▀▀  ▘ ▘▝▀▘▝▀  ▘ ▀▘▘▝ ▘ ▝▀ ▝▀▘ ▀ ▝▀▘▌
-- vim.env.PATH = "/usr/bin:" .. vim.env.PATH
--- ------------------------------ Load Scratch --------------------------------
require("scratch")
---  ----------------------------- Load Keymaps --------------------------------
require("keymaps")
---  ---------------------------- Bootstrap Lazy -------------------------------
require("lazy-config")
---  ----------------------------- Load Options --------------------------------
require("options")
---  ----------------------------- Setup Plugins -------------------------------
require("plugins-config.nvimtree")
require("plugins-config.oil")
require("plugins-config.which-key")
--- ----------------------------------------------------------------------------
require("modules.set_local_path").setup_autocmds()
