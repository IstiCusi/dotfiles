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
require("plugins-config.nvimtree")
require("plugins-config.oil")
require("plugins-config.which-key")
--- ----------------------------------------------------------------------------
require("modules.set_c_cpp_default_paths").setup_c_cpp_autocmds()
require("modules.set_python_default_paths").setup_python_autocmds()
require("modules.set_lua_default_paths").setup_lua_autocmds()
require("modules.print")


