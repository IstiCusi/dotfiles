require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nvim_tmux_nav = require('nvim-tmux-navigation')

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>", { silent = true })
map('t', '<Esc>', [[<C-\><C-n>]])
map('t', 'jj', [[<C-\><C-n>]])
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


map('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
map('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- local M = {}
-- M.setup_vim_visual_multi = function()
--     vim.api.nvim_set_keymap('n', '<A-d>', '<Plug>(VM-Find-Under)',
--         { noremap = true, silent = true, desc = "MultiCursor - Find Under" })
--     vim.api.nvim_set_keymap('n', '<A-n>', '<Plug>(VM-Find-Next)',
--         { noremap = true, silent = true, desc = "MultiCursor - Find Next" })
--     vim.api.nvim_set_keymap('n', '<A-p>', '<Plug>(VM-Find-Prev)',
--         { noremap = true, silent = true, desc = "MultiCursor - Find Prev" })
--     vim.api.nvim_set_keymap('n', '<A-s>', '<Plug>(VM-Skip)',
--         { noremap = true, silent = true, desc = "MultiCursor - Skip Region" })
--     vim.api.nvim_set_keymap('n', '<A-r>', '<Plug>(VM-Remove)',
--         { noremap = true, silent = true, desc = "MultiCursor - Remove Region" })
--     vim.api.nvim_set_keymap('n', '<A-q>', '<Plug>(VM-Quit)',
--         { noremap = true, silent = true, desc = "MultiCursor - Quit" })
-- end
--
-- return M
