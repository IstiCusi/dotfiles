---  ----------------------------- Local Alias -------------------------------
local lazypath = vim.fn.stdpath("config") .. "/installations/plugins/lazy.nvim"
local pluginpath = vim.fn.stdpath("config") .. "/installations/plugins"
print(lazypath)
---  --------------------------------------------------------------------------

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = true },
  root = pluginpath, 
  change_detection = { notify = false, },
}
)
