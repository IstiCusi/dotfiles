-- ----------------------- Man pages for C mainly -------------------------------

vim.api.nvim_set_keymap('n', '<F3>', ':lua SearchManPageForCurrentWord()<CR>', { noremap = true })
function SearchManPageForCurrentWord()
  local word = vim.fn.expand("<cword>")
  vim.cmd('Man ' .. word)
end

-- TODO: Is this required
require 'lspconfig'.zls.setup{}

-- ------------- My path update to fix the #include <> gf features -------------

vim.opt.tags:append('/home/phonon/Development/libraries/c-libraries/glibc-2.35/tags')
vim.opt.path:append("/usr/include/c++/12/**")
vim.opt.path:append("/usr/local/include/**")
vim.opt.path:append("/usr/include/**")
vim.opt.path:append("./**")

-- ------------- Visual Selection Color Choice --------------------------------

-- vim.cmd("highlight Visual guibg=#AAFFAA")
-- vim.cmd("highlight Visual guibg=#FBC6FF")
-- vim.cmd("highlight Visual guibg=#A573FF")
vim.cmd("highlight Visual guibg=#350094")

-- vim.cmd("highlight VisualNC guibg=#00FF00")
-- vim.cmd("highlight VisualNOS guifg=#dc322f")
-- vim.cmd("highlight St_VisualMode cterm=bold gui=bold guifg=#002b36 guibg=#00FF00")
-- vim.cmd("highlight St_VisualModeSep guifg=#2aa198 guibg=#00FF00")


-- ----------------------------------------------------------------------------
require("oil").setup(
  { delete_to_trash = true,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-h>"] = false,
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = false,
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  }
)
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- -----------------------------------------------------------------------------

vim.g.VM_maps = {
    ["Find Under"] = "<A-d>",  -- Alt + d to start selection
    ["Find Subword Under"] = "<A-d>",  -- Alt + d to start selection for subwords (optional)
}

-- Disable all other mappings by setting them to an empty string
for key, _ in pairs(vim.g.VM_maps) do
    if key ~= "Find Under" and key ~= "Find Subword Under" then
        vim.g.VM_maps[key] = ""
    end
end

