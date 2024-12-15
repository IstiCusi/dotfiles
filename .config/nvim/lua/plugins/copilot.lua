return {
	-- Copilot Plugin
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "<C-A-k>", -- Springe zum vorherigen Vorschlag im Panel
						jump_next = "<C-A-j>", -- Springe zum nächsten Vorschlag im Panel
						accept = "<C-A-CR>", -- Vorschlag im Panel annehmen
						refresh = "<C-A-r>", -- Panel aktualisieren
						open = "<C-A-o>", -- Panel öffnen
					},
					layout = {
						position = "bottom",
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<C-A-a>", -- Vorschlag annehmen
						next = "<C-A-j>", -- Nächsten Vorschlag anzeigen
						prev = "<C-A-k>", -- Vorherigen Vorschlag anzeigen
						dismiss = "<C-A-x>", -- Vorschlag ablehnen
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},

	-- copilot-cmp Integration
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
