--- ============================Pure neovim/vim settings ===================== 

---  ----------------------------- Local Alias -------------------------------
local opt = vim.opt
local g   = vim.g
---  --------------------------------------------------------------------------

--- Switch off not functioning providers
g.loaded_perl_provider = 0

--- Clipboard Usage
opt.clipboard:append("unnamedplus")

--- Keys Handling In Terminal
opt.backspace = "indent,eol,start"

--- Color Scheme 
vim.cmd("colorscheme tokyonight")

--- Color Settings For Terminal
opt.termguicolors = true    --- Use correct terminal colors
opt.background = "dark"     --- Use always the dark version of a scheme

---  Explorer Features
g.netrw_liststyle = 3       --- In `Explore` use tree view

---  Line Numbering and Cursorline Treatment
opt.relativenumber = true   --- Relative numbers from actual line
opt.number = true           --- Show alos absolute number
opt.wrap = false            --- Keep line unwrapped
opt.cursorline = true
opt.signcolumn = "yes"      --- Use at the left a raw for editor signs

---  Tab Stops
opt.autoindent = true       --- Indent in next line
opt.expandtab = true        --- Make tabs to spaces
opt.tabstop = 2             --- 2 spaces or 1 tab 
opt.shiftwidth = 2          --- 2 spaces used to intend

--- Search Options
opt.ignorecase = true       --- Make case unsensitive 
opt.smartcase = true        --- except in case of mixed upper/lower

-- Session Settings
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"


-- Debug Function
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "number,relativenumber",
  callback = function()
    if not vim.wo.number or not vim.wo.relativenumber then
      -- Print a message and the current buffer information to help track the cause
      print("Line numbers were disabled in buffer " .. vim.fn.bufname() .. " by:")
      print(debug.traceback())
    end
  end
})



