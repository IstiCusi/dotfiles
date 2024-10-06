--- TODO:  space ca  .. keygroups needs an update about group c

---  ----------------------------- Local Alias -------------------------------
local g   = vim.g
local map = vim.keymap.set
Phonon = Phonon or {}
Phonon.keygroups = {}
---  --------------------------------------------------------------------------

--- Set Leader Key
g.mapleader = " "

--- Close Window and Buffer
map("n", "<C-c>", "<cmd>bd<CR>", { desc = "Close window and buffer" })

-- Split Maximer
Phonon.maximizerKeys = { "<leader>mm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" }

--- Set Standard ESC Variants And Other Exit Variants
map("n", ";", ":", { desc = "Enter command mode (CMD) with ;" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode by typing 'jk'" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode by typing 'jj'" })
map('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode with ESC" })
map('t', 'jj', [[<C-\><C-n>]], { desc = "Exit terminal mode by typing 'jj'" })

--- Using Tabs To Switch Between Buffers And Tabs
map ("n", "<leader><S-Tab>", "<cmd>bp<CR>", { desc = "Jump to previous buffer" })
map ("n", "<leader><Tab>", "<cmd>bn<CR>", { desc = "Jump to next buffer" })
map ("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Jump to previous tab" })
map ("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Jump to next tab" })

--- Telescope bindings
table.insert(Phonon.keygroups, { "<leader>f", "Telescope", desc= "Telescope" })
function Phonon.telescopeKeys()
  local keymap = vim.keymap
  keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
  keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
  keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
  keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
  keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
end

--- Open New Tabs
table.insert(Phonon.keygroups, { "<leader>t", "Tabs", desc= "Tabs" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map('n', '<leader>tf', function()
  require('telescope.builtin').find_files({
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selected = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        vim.cmd('tabnew ' .. selected.path)
      end)
      return true
    end,
  })
end, { desc = "Open in new tab" })

--- Oil File Explorer
function OilOpen()
  vim.cmd("split | wincmd j")
  require("oil").open()
end

map("n", "-", OilOpen, { desc = "Open Oil File Browser" })

Phonon.oilKeys = {
  ["?"] = "actions.show_help",
  ["<CR>"] = "actions.select",
  ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
  ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
  ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
  ["<C-p>"] = "actions.preview",
  ["<C-c>"] = "actions.close",
  ["<C-l>"] = "actions.refresh",
  ["-"] = "actions.parent",
  ["_"] = "actions.open_cwd",
  ["`"] = "actions.cd",
  ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
  ["gs"] = "actions.change_sort",
  ["gx"] = "actions.open_external",
  ["g."] = "actions.toggle_hidden",
  ["g\\"] = "actions.toggle_trash",
}

--- Nvim File Explorer
table.insert(Phonon.keygroups, { "<leader>e", "Explorer", desc= "Explorer" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

function Phonon.nvimTreeKeys(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- Auto Session Keys
table.insert(Phonon.keygroups, { "<leader>w", "Session", desc= "Session" })
function Phonon.autoSession()
  local keymap = vim.keymap
  keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
  keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
  keymap.set("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })
end

-- Treesitter Selection mappings
Phonon.treesitterSelection = {
  init_selection = "<C-space>",
  node_incremental = "<C-space>",
  scope_incremental = false,
  node_decremental = "<bs>",
}


-- Special keys for programming

table.insert(Phonon.keygroups, { "<leader>s", "Subtitute", desc= "Substitute" })
function Phonon.substituteKeys()
    local keymap = vim.keymap
    local substitute = require("substitute")
    keymap.set("n", "<leader>ss", substitute.operator, { desc = "Substitute with motion" })
    keymap.set("n", "<leader>sS", substitute.line, { desc = "Substitute line" })
    keymap.set("x", "<leader>sv", substitute.visual, { desc = "Substitute in visual mode" })
end

-- Other convinient mappings
table.insert(Phonon.keygroups, { "<leader>n", "Switch On/Off", desc= "Switch On/Off" })
map('n', '<leader>nl', ':IBLToggle<CR>', { desc = "Switch on/off indent lines" })
map('n', '<leader>nh', ':lua ToggleHlsearch()<CR>', { desc = "Switch on/off highlight" })
map('n', '<leader>nn', 'f"i\\n<ESC>', { desc = "Add \\n" }) -- addes \n in c to string 

function ToggleHlsearch()
  if vim.o.hlsearch then vim.o.hlsearch = false else vim.o.hlsearch = true
  end
end

-- Surround Keys
table.insert(Phonon.keygroups, { "<leader>S", "Surround", desc= "Surround" })
Phonon.surroundKeys = {
  insert = false,                 -- UNSET, because too slow input mode
  insert_line = false,            -- UNSET because too slow input mode 
  normal = "<leader>S",           -- Surround in Normal mode
  normal_cur = "<leader>SC",      -- Surround current line/selection in Normal mode
  visual = "<leader>SV",          -- Surround in Visual mode
  visual_line = "<leader>SL",     -- Surround entire line in Visual mode
  delete = "<leader>SD",          -- Delete surround
  change = "<leader>SC",          -- Change surround
}

-- Correct with the Lsp server 
table.insert(Phonon.keygroups, { "<leader>c", "Correct", desc= "Correct" })
table.insert(Phonon.keygroups, { "<leader>r", "Smart Rename", desc= "Smart Rename" })
