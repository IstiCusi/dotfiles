-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local lualine = require("lualine")
-- 		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
--
-- 		local colors = {
-- 			blue = "#65D1FF",
-- 			green = "#3EFFDC",
-- 			violet = "#FF61EF",
-- 			yellow = "#FFDA7B",
-- 			red = "#FF4A4A",
-- 			fg = "#c3ccdc",
-- 			bg = "#2b5938",
-- 			inactive_bg = "#2c3043",
-- 		}
--
-- 		local my_lualine_theme = {
-- 			normal = {
-- 				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			insert = {
-- 				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			visual = {
-- 				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			command = {
-- 				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			replace = {
-- 				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			inactive = {
-- 				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
-- 				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 			},
-- 		}
--
-- 		-- configure lualine with modified theme
-- 		lualine.setup({
-- 			options = {
-- 				theme = my_lualine_theme,
-- 			},
-- 			sections = {
--
-- 				lualine_x = {
-- 					{
-- 						lazy_status.updates,
-- 						cond = lazy_status.has_updates,
-- 						color = { fg = "#ff9e64" },
-- 					},
-- 					{ "encoding" },
-- 					{ "fileformat" },
-- 					{ "filetype" },
-- 					-- {
-- 					--   'datetime',
-- 					--   style = 'default',
-- 					-- }
-- 				},
-- 				-- lualine_z = {
-- 				--     {
-- 				--         function()
-- 				--             for _, buf in ipairs(vim.api.nvim_list_bufs()) do
-- 				--                 if vim.api.nvim_buf_get_option(buf, 'modified') then
-- 				--                     return 'Unsaved buffers' -- any message or icon
-- 				--                 end
-- 				--             end
-- 				--             return ''
-- 				--         end,
-- 				--     },
-- 				-- },
-- 			},
-- 		})
-- 	end,
-- }
--

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	after = "zbirenbaum/copilot.lua", -- Copilot muss zuerst geladen werden
-- 	dependencies = { "nvim-tree/nvim-web-devicons", "zbirenbaum/copilot.lua" },
-- 	config = function()
-- 		local lualine = require("lualine")
--
-- 		-- Farben für lualine
-- 		local colors = {
-- 			blue = "#65D1FF",
-- 			green = "#3EFFDC",
-- 			violet = "#FF61EF",
-- 			yellow = "#FFDA7B",
-- 			red = "#FF4A4A",
-- 			fg = "#c3ccdc",
-- 			bg = "#2b5938",
-- 			inactive_bg = "#2c3043",
-- 		}
--
-- 		-- Farbschema für lualine
-- 		local my_lualine_theme = {
-- 			normal = {
-- 				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			insert = {
-- 				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			visual = {
-- 				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			command = {
-- 				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			replace = {
-- 				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
-- 				b = { bg = colors.bg, fg = colors.fg },
-- 				c = { bg = colors.bg, fg = colors.fg },
-- 			},
-- 			inactive = {
-- 				a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
-- 				b = { bg = colors.inactive_bg, fg = colors.fg },
-- 				c = { bg = colors.inactive_bg, fg = colors.fg },
-- 			},
-- 		}
--
-- 		-- Funktion, um den Copilot-Status in der Statusleiste anzuzeigen
-- 		local function copilot_status()
-- 			local copilot_enabled = vim.g.copilot_enabled
-- 			if copilot_enabled then
-- 				return "✈️" -- Symbol für aktivierten Copilot
-- 			else
-- 				return "" -- Leere Zeichenkette, wenn Copilot deaktiviert ist
-- 			end
-- 		end
--
-- 		-- Konfiguration von lualine mit Copilot-Status
-- 		lualine.setup({
-- 			options = {
-- 				theme = my_lualine_theme,
-- 			},
-- 			sections = {
-- 				lualine_x = {
-- 					{ copilot_status }, -- Zeige Copilot-Status in der Statusleiste an
-- 					{ "encoding" },
-- 					{ "fileformat" },
-- 					{ "filetype" },
-- 				},
-- 			},
-- 		})
--
-- 		-- Status-Handler für Copilot, um lualine zu aktualisieren
-- 		vim.defer_fn(function()
-- 			require("copilot.api").register_status_notification_handler(function(data)
-- 				vim.g.copilot_enabled = data.status == "Normal"
-- 				lualine.refresh() -- Aktualisiere lualine
-- 			end)
-- 		end, 100) -- Verzögerung für den Start des Handlers
-- 	end,
-- }

return {
	"nvim-lualine/lualine.nvim",
	after = "zbirenbaum/copilot.lua", -- Copilot muss zuerst geladen werden
	dependencies = { "nvim-tree/nvim-web-devicons", "zbirenbaum/copilot.lua" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- Lazy status für Updates

		-- Farben für lualine
		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#2b5938",
			inactive_bg = "#2c3043",
		}

		-- Farbschema für lualine
		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.fg },
				c = { bg = colors.inactive_bg, fg = colors.fg },
			},
		}

		-- Funktion, um den Copilot-Status in der Statusleiste anzuzeigen
		local function copilot_status()
			return vim.g.copilot_enabled and "✈️" or ""
		end

		-- Konfiguration von lualine mit Copilot-Status und Lazy-Update-Anzeige
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates, -- Zeigt Anzahl der Lazy-Updates
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ copilot_status }, -- Zeigt Copilot-Status
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})

		-- Status-Handler für Copilot, um lualine zu aktualisieren
		vim.defer_fn(function()
			require("copilot.api").register_status_notification_handler(function(data)
				vim.g.copilot_enabled = data.status == "Normal"
				lualine.refresh() -- Aktualisiert lualine
			end)
		end, 100)
	end,
}
