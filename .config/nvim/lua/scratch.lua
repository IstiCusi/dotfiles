-- Get the config directory for the current Neovim instance
local config_dir = vim.fn.stdpath('config')
local scratch_file_path = config_dir .. "/SCRATCH.md"

-- Check if no file is provided on startup
if vim.fn.argc() == 0 then
  -- Open the specified scratch file
  vim.api.nvim_command('e ' .. scratch_file_path) -- Open the scratch file at the specified path

  -- Optional: Mark the buffer with certain attributes to treat it as a scratch buffer
  vim.bo.bufhidden = 'hide'  -- Allow buffer to be hidden without saving
  vim.bo.swapfile = false     -- Disable swap file for the buffer
  vim.bo.modifiable = true    -- Ensure the buffer is modifiable
end

