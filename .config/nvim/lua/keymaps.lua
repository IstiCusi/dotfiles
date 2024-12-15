--- TODO:  space ca  .. keygroups needs an update about group c

---  ----------------------------- Local Alias -------------------------------
local g = vim.g
local map = vim.keymap.set
Phonon = Phonon or {}
Phonon.keygroups = {}
---  --------------------------------------------------------------------------

--- Set Leader Key ------------------------------------------------------------
g.mapleader = " "

-- Exit Neovim without saving -------------------------------------------------
vim.api.nvim_set_keymap("n", "ZX", "ZQ", { noremap = true, silent = true })

--- Close Window and Buffer ---------------------------------------------------
map("n", "<C-c>", "<cmd>bd<CR>", { desc = "Close window and buffer" })
map("t", "<C-c>", "<cmd>bd!<CR>", { desc = "Close window and buffer" })

--- Open nvim internal terminal ----------------------------------------------
map("n", "<leader>tt", ":terminal<CR>", { noremap = true, silent = true, desc = "Terminal" })
--- TODO: C-c to close terminal in all cases (normal and insert mode)

-- Leaping -------------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader><leader>", desc = "Leap", icon = "🦘" })
map({ "n", "x", "o" }, "<leader><leader>", "<Plug>(leap)", { desc = "Leap"  })

-- Clean buffer without changing clipboard -----------------------------------
table.insert(Phonon.keygroups, { "<leader>G", desc = "Empty Buffer", icon = "🗑️" })
vim.api.nvim_set_keymap("n", "<leader>GG", 'gg"_dG', { noremap = true, silent = true })

-- Split Maximer -------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>m", desc = "Maximize/minimize a split", icon = "🔳" })
Phonon.maximizerKeys = { "<leader>mm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" }

--- Set Standard ESC Variants And Other Exit Variants ------------------------
map("n", ";", ":", { desc = "Enter command mode (CMD) with ;" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode by typing 'jk'" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode by typing 'jj'" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode with ESC" })
map("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminal mode by typing 'jj'" })

--- Using Tabs To Switch Between Buffers And Tabs ----------------------------
map("n", "<leader><S-Tab>", "<cmd>bp<CR>", { desc = "Jump to previous buffer" })
map("n", "<leader><Tab>", "<cmd>bn<CR>", { desc = "Jump to next buffer" })
map("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Jump to previous tab" })
map("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Jump to next tab" })

--- Telescope and search bindings -------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>f", desc = "Telescope" })
function Phonon.telescopeKeys()
	local keymap = vim.keymap
	keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
	keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
	keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
	keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
	keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	keymap.set( "n", "<leader>fi", ':lua require("modules.lookup_includes").search_standard_includes()<CR>', { desc = "Search Includes" })
end


vim.api.nvim_set_keymap("n", "<leader>fm", ":lua SearchManPageForCurrentWord()<CR>", { noremap = true , desc ="Search Man Pages"})
function SearchManPageForCurrentWord()
    local filetype = vim.bo.filetype
    if filetype ~= "c" and filetype ~= "cpp" then
        print("No C/C++ file detected. Aborting.")
        return
    end

    local word = vim.fn.expand("<cword>")
    if word == "" then
        print("No word under cursor. Aborting.")
        return
    end

    local sections = { "2", "3" }
    local found = false

    for _, section in ipairs(sections) do
        local status, _ = pcall(function()
            vim.cmd("Man " .. section .. " " .. word)
        end)

        if status then
            found = true
            break
        end
    end

    if not found then
        print("No relevant C/C++ manpage found for: " .. word)
    end
end




--- Open New Tabs ------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>t", desc = "Tabs" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tf", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
				local selected = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				vim.cmd("tabnew " .. selected.path)
			end)
			return true
		end,
	})
end, { desc = "Open in new tab" })

--- Oil File Explorer -------------------------------------------------------
function OilOpen()
	vim.cmd("split | wincmd j")
	require("oil").open()
end
table.insert(Phonon.keygroups, { "<leader>-", desc = "Open Oil As Split", icon="🛢️" })

map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
map("n", "<leader>-", OilOpen, { desc = "Open Oil As Split" })

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

--- Nvim File Explorer ------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>e" , desc = "Explorer", icon ="📂" })
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

function Phonon.nvimTreeKeys(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

-- Auto Session Keys --------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>w", desc = "Session", icon = "💾" })
function Phonon.autoSession()
	local keymap = vim.keymap
	keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
	keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
	keymap.set("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })
end

-- Treesitter Selection mappings --------------------------------------------
Phonon.treesitterSelection = {
	init_selection = "<C-space>",
	node_incremental = "<C-space>",
	scope_incremental = false,
	node_decremental = "<bs>",
}

-- Special keys for programming ---------------------------------------------

table.insert(Phonon.keygroups, { "<leader>s", desc = "Substitute", icon ="🪚"})
function Phonon.substituteKeys()
	local keymap = vim.keymap
	local substitute = require("substitute")
	keymap.set("n", "<leader>ss", substitute.operator, { desc = "Substitute with motion" })
	keymap.set("n", "<leader>sS", substitute.line, { desc = "Substitute line" })
	keymap.set("x", "<leader>sv", substitute.visual, { desc = "Substitute in visual mode" })
end

-- Other convinient mappings -------------------------------------------------
-- table.insert(Phonon.keygroups, { "<leader>n", "Switch On/Off", desc = "Switch On/Off", icon = "⏻" })
table.insert(Phonon.keygroups, { "<leader>n", desc = "Switch On/Off", icon = "⏻" })
map("n", "<leader>nl", ":IBLToggle<CR>", { desc = "Switch on/off indent lines" })
map("n", "<leader>nh", ":lua ToggleHlsearch()<CR>", { desc = "Switch on/off highlight" })
map("n", "<leader>nn", 'f"i\\n<ESC>', { desc = "Add \\n" }) -- addes \n in c to string
map("n", "<leader>nz", ":set foldenable!<CR>", { desc = "Toggle Folding" })

vim.keymap.set("n", "<leader>nd", function()
	require("toggle_lsp_diagnostics").toggle_diagnostics()
end, { desc = "Toggle Diagnostics" })

function ToggleHlsearch()
	if vim.o.hlsearch then
		vim.o.hlsearch = false
	else
		vim.o.hlsearch = true
	end
end

-- Surround Keys --------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>S", desc = "Surround", icon = "🌀" })
Phonon.surroundKeys = {
	insert = false, -- unset, because too slow input mode
	insert_line = false, -- unset because too slow input mode
	normal = "<leader>s", -- surround in normal mode
	normal_cur = "<leader>sc", -- surround current line/selection in normal mode
	visual = "<leader>sv", -- surround in visual mode
	visual_line = "<leader>sl", -- surround entire line in visual mode
	delete = "<leader>sd", -- delete surround
	change = "<leader>sc", -- change surround
}

-- trouble keys ----------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>x", desc = "trouble", icon = "⚠️" })
Phonon.troublekeys = {
	{ "<leader>xw", "<cmd>trouble diagnostics toggle<cr>", desc = "open trouble workspace diagnostics" },
	{ "<leader>xd", "<cmd>trouble diagnostics toggle filter.buf=0<cr>", desc = "open trouble document diagnostics" },
	{ "<leader>xq", "<cmd>trouble quickfix toggle<cr>", desc = "open trouble quickfix list" },
	{ "<leader>xl", "<cmd>trouble loclist toggle<cr>", desc = "open trouble location list" },
	{ "<leader>xt", "<cmd>trouble todo toggle<cr>", desc = "open todos in trouble" },
}

-- delete comment --------------------------------------------------------------
-- todo: because it interferes with normal motions, the whichkey plugin does not propose a completion
map("n", "dc", ':lua require("modules.delete-comment").delete_comment()<cr>', { desc = "delete comment" })

-- correct with the lsp server -------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>c", desc = "Correct", icon ="🩹" })
table.insert(Phonon.keygroups, { "<leader>r", desc = "Refactoring", icon="🔨" })

-- Go for symbol actions -------------------------------------------------------

table.insert(Phonon.keygroups, { "gr", desc = "LSP Symbol Actions", icon = "🔍" })
table.insert(Phonon.keygroups, { "gra", desc = "Code Action", icon = "🛠️" })
table.insert(Phonon.keygroups, { "gri", desc = "Go to Implementation", icon = "🚀" })
table.insert(Phonon.keygroups, { "grn", desc = "Rename Symbol", icon = "✏️" })
table.insert(Phonon.keygroups, { "grr", desc = "Find References", icon = "🔗" })

-- git -------------------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>h",  desc = "git", icon ="🌱" })

function Phonon.gitKeys(bufnr)
	local gs = package.loaded.gitsigns
	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
	end
	map("n", "]h", gs.next_hunk, "Next Hunk")
	map("n", "[h", gs.prev_hunk, "Prev Hunk")
	map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
	map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
	map("v", "<leader>hs", function()
		gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, "Stage hunk")
	map("v", "<leader>hr", function()
		gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, "Reset hunk")
	map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
	map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
	map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
	map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
	map("n", "<leader>hb", function()
		gs.blame_line({ full = true })
	end, "Blame line")
	map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
	map("n", "<leader>hd", gs.diffthis, "Diff this")
	map("n", "<leader>hD", function()
		gs.diffthis("~")
	end, "Diff this ~")
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
end

Phonon.lazyGitkeys = {
	{ "<leader>hg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
}

-- Format --------------------------------------------------------------------
map({ "n", "v" }, "<leader>cf", function()
	local conform = require("conform")
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range (in visual mode)" })

-- Multicursor map -----------------------------------------------------------

map("n", "<A-d>", "<Plug>(VM-Find-Under)", { noremap = true, silent = true, desc = "MultiCursor - Start Find Under" })
Phonon.VM_maps = {
	["Find Under"] = "<A-d>", -- Sucht das aktuelle Wort
	["Find Subword Under"] = "<A-d>", -- Sucht Subwort im visuellen Modus
}

-- Phonon.VM_maps = {
-- 	["Find Under"] = "<C-n>", -- Findet das aktuelle Wort unter dem Cursor
-- 	["Find Subword Under"] = "<C-n>", -- Findet das Subwort, speziell im Visual-Modus
--
-- 	["Add Cursor Down"] = "<C-Down>", -- Fügt Cursor nach unten hinzu
-- 	["Add Cursor Up"] = "<C-Up>", -- Fügt Cursor nach oben hinzu
-- 	["Select All"] = "\\A", -- Wählt alle Vorkommen des Wortes im Dokument
-- 	["Start Regex Search"] = "\\/", -- Startet eine Regex-Suche für Auswahl
--
-- 	["Switch Mode"] = "<Tab>", -- Wechselt zwischen Cursor- und Erweiterungsmodus
-- 	["Goto Next"] = "]", -- Springt zum nächsten ausgewählten Bereich
-- 	["Goto Prev"] = "[", -- Springt zum vorherigen ausgewählten Bereich
-- 	["Seek Next"] = "<C-f>", -- Springt schnell zur nächsten Auswahl
-- 	["Seek Prev"] = "<C-b>", -- Springt schnell zur vorherigen Auswahl
--
-- 	["Remove Region"] = "Q", -- Entfernt die aktuelle Region
-- 	["Skip Region"] = "q", -- Überspringt die aktuelle Region
-- }

-- Nvorg Mode ----------------------------------------------------------------
table.insert(Phonon.keygroups, { "<leader>o", "neorg", desc = "neorg", icon ="🗒️" })
map("n", "<Leader>oc", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { noremap = true, silent = true })
map("n", "<Leader>om", "<Plug>(neorg.looking-glass.magnify-code-block)", { noremap = true, silent = true })
map("n", "<Leader>od", "<Plug>(neorg.tempus.insert-date)", { noremap = true, silent = true })
map("n", "<Leader>oi", "<Plug>(neorg.pivot.list.invert)", { noremap = true, silent = true })
map("n", "<Leader>ol", "<Plug>(neorg.pivot.list.toggle)", { noremap = true, silent = true })
map("n", "<Leader>ota", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", { noremap = true, silent = true })
map("n", "<Leader>otc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", { noremap = true, silent = true })
map("n", "<Leader>otd", "<Plug>(neorg.qol.todo-items.todo.task-done)", { noremap = true, silent = true })
map("n", "<Leader>oth", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", { noremap = true, silent = true })
map("n", "<Leader>oti", "<Plug>(neorg.qol.todo-items.todo.task-important)", { noremap = true, silent = true })
map("n", "<Leader>otp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", { noremap = true, silent = true })
map("n", "<Leader>otr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", { noremap = true, silent = true })
map("n", "<Leader>otu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { noremap = true, silent = true })

map("n", "<leader>op", ':lua require("nabla").popup({border = "single"})<CR>', { desc = "Nabla" })
map("n", "<leader>or", ':lua require("nabla").toggle_virt()<CR>', { desc = "Nabla toggle" })

-- Easy Align -----------------------------------------------------------------

table.insert(Phonon.keygroups, { "ga", icon = "📏" })
map("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true, desc = "Easy Align" })
map("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true, desc = "Easy Align" })

-- Copilot --------------------------------------------------------------------
function ToggleCopilot()
	-- Check the current status by invoking Copilot's status command
	local copilot_status = vim.g.copilot_enabled -- This tracks if Copilot is currently enabled

	if copilot_status then
		-- If enabled, disable Copilot
		vim.cmd("Copilot disable")
		vim.g.copilot_enabled = false
		print("Copilot disabled")
	else
		-- If disabled, enable Copilot
		vim.cmd("Copilot enable")
		vim.g.copilot_enabled = true
		print("Copilot enabled")
	end
end

-- Assign the toggle function to a keybinding
vim.api.nvim_set_keymap(
	"n",
	"<leader>cp",
	":lua ToggleCopilot()<CR>",
	{ desc = "Toggle CoPilot", noremap = true, silent = true }
)

-- Printing -----------------------------------------------------------------
--
vim.api.nvim_set_keymap("n", "<leader>np", ":lua print_with_minted()<CR>", { desc = "Print file" })

Phonon.venvKeys = {
	{ "<leader>nv", "<cmd>VenvSelect<cr>", desc = "Choose Python variant" },
}
