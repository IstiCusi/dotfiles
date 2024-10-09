--- TODO: Make that to a plugin with option: save when leaving, or keep unsaved and warn, or skip any mod

local config_dir = vim.fn.stdpath('config')
local scratch_file_path = config_dir .. "/SCRATCH.md"

if vim.fn.argc() == 0 then
  vim.api.nvim_command('e ' .. scratch_file_path)
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
  vim.bo.modifiable = true
  vim.cmd([[
    autocmd BufLeave <buffer> set nomodified
  ]])
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
end
