--- ============================Pure neovim/vim settings =====================

---  ----------------------------- Local Alias -------------------------------
local opt = vim.opt
local g = vim.g
---  --------------------------------------------------------------------------

-- Get the global pyenv Python version
local pyenv_global_python = vim.fn.system("pyenv global"):gsub("%s+", "")

-- Set the Python3 host program for Neovim (not for the editor)
-- g.python3_host_prog = pyenv_global_python

local version = vim.fn.system("pyenv global"):gsub("%s+", "")
g.python3_host_prog = "/home/phonon/.pyenv/versions/" .. version .. "/bin/python"

--- Switch off not functioning providers
g.loaded_perl_provider = 0

--- Clipboard Usage
opt.clipboard:append("unnamedplus")

--- Keys Handling In Terminal
opt.backspace = "indent,eol,start"

--- Color Scheme
vim.cmd("colorscheme tokyonight")

--- Color Settings For Terminal
opt.termguicolors = true --- Use correct terminal colors
opt.background = "dark" --- Use always the dark version of a scheme

--- Zsh Settings For Terminal

--- TODO

---  Explorer Features
g.netrw_liststyle = 3 --- In `Explore` use tree view

---  Line Numbering and Cursorline Treatment
opt.relativenumber = true --- Relative numbers from actual line
opt.number = true --- Show alos absolute number
opt.wrap = false --- Keep line unwrapped
opt.cursorline = true
opt.signcolumn = "yes" --- Use at the left a raw for editor signs

---  Tab Stops
opt.autoindent = true --- Indent in next line
opt.expandtab = true --- Make tabs to spaces
opt.tabstop = 2 --- 2 spaces or 1 tab
opt.shiftwidth = 2 --- 2 spaces used to intend

--- Search Options
opt.ignorecase = true --- Make case unsensitive
opt.smartcase = true --- except in case of mixed upper/lower

-- Session Settings
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Debug Function
-- vim.api.nvim_create_autocmd("OptionSet", {
-- 	pattern = "number,relativenumber",
-- 	callback = function()
-- 		if not vim.wo.number or not vim.wo.relativenumber then
-- 			-- Print a message and the current buffer information to help track the cause
-- 			print("Line numbers were disabled in buffer " .. vim.fn.bufname() .. " by:")
-- 			print(debug.traceback())
-- 		end
-- 	end,
-- })

-- Co Pilot Initial

vim.cmd("Copilot disable")

-- Write with Formating

vim.api.nvim_create_user_command("W", function(opts)
	-- Formatieren der Datei
	require("conform").format({ lsp_fallback = true, async = false })
	-- Speichern mit optionalem Argument (z. B. Dateiname)
	vim.cmd("write " .. (opts.args or ""))
end, {
	desc = "Write file with formatting",
	nargs = "?", -- Optionales Argument erlauben
})

vim.api.nvim_create_user_command("WA", function()
	-- Formatieren aller Dateien
	require("conform").format({ lsp_fallback = true, async = false })
	-- Alle Dateien speichern
	vim.cmd("wall")
end, {
	desc = "Write all files with formatting",
})

-- Set background color for floating windows (api for example)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000011" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000011", fg = "#223322" })

-- FixWhiteSpace

-- vim.api.nvim_create_user_command("FixWhiteSpace", function()
--   vim.cmd([[%s/\s\+$//e]])
-- end, { desc = "Remove trailing whitespace" })

vim.api.nvim_create_user_command("FixWhiteSpace", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local modified = false

  for i, line in ipairs(lines) do
    local cleaned = line:gsub("%s+$", "")
    if cleaned ~= line then
      lines[i] = cleaned
      modified = true
    end
  end

  if modified then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  end
end, { desc = "Remove trailing whitespace" })

