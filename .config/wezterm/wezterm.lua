-- local wezterm = require("wezterm")
--
-- return {
-- 	font = wezterm.font("FiraCode Nerd Font Mono"),
-- 	font_size = 14.0,
-- 	default_prog = { "/bin/zsh" },
-- 	color_scheme = "Tokyo Night",
-- 	colors = {
-- 		cursor_bg = "#FC05F1", -- Setzt die Hintergrundfarbe des Cursors
-- 		cursor_border = "#FC05F1", -- Setzt die Randfarbe des Cursors
-- 		cursor_fg = "#000000", -- Optional: Setzt die Textfarbe im Cursor, wenn du den Text sehen möchtest
-- 		ansi = {
-- 			"#1245D5", -- Ändere nur color0
-- 			nil, -- color1 (unverändert)
-- 			nil, -- color2 (unverändert)
-- 			nil, -- color3 (unverändert)
-- 			nil, -- color4 (unverändert)
-- 			nil, -- color5 (unverändert)
-- 			nil, -- color6 (unverändert)
-- 			nil, -- color7 (unverändert)
-- 		},
-- 	},
-- }

local wezterm = require("wezterm")

-- Lade das Tokyo Night Farbschema
local scheme = wezterm.color.get_builtin_schemes()["Tokyo Night"]

-- Ändere nur color0 und übernehme die anderen Farben aus dem Standard-Schema
scheme.ansi[1] = "#1245D5"

return {
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 14.0,
	default_prog = { "/bin/zsh" },
	color_scheme = "Tokyo Night",
	colors = {
		cursor_bg = "#FC05F1", -- Setzt die Hintergrundfarbe des Cursors
		cursor_border = "#FC05F1", -- Setzt die Randfarbe des Cursors
		cursor_fg = "#000000", -- Optional: Setzt die Textfarbe im Cursor
		ansi = scheme.ansi, -- Verwende das Schema mit der geänderten Farbe für color0
	},
}
