-- local builtin = require("telescope.builtin")
-- local Job = require("plenary.job")
--
-- local M = {}
--
-- -- Funktion, um die Include-Pfade aller relevanten Bibliotheken mit pkg-config zu sammeln
-- local function get_all_pkgconfig_includes()
-- 	local include_dirs = {}
--
-- 	-- Erhalte alle Pakete, die von pkg-config unterstützt werden
-- 	local pkg_list = Job:new({
-- 		command = "pkg-config",
-- 		args = { "--list-all" },
-- 	}):sync()
--
-- 	-- Iteriere über alle Pakete und sammle die Include-Pfade
-- 	for _, pkg in ipairs(pkg_list) do
-- 		local pkg_name = pkg:match("^([^%s]+)") -- Nimm den Paketnamen (erster Teil der Zeile)
--
-- 		-- Erhalte die Include-Pfade für jedes Paket
-- 		local result = Job:new({
-- 			command = "pkg-config",
-- 			args = { "--cflags-only-I", pkg_name },
-- 		}):sync()
--
-- 		for _, line in ipairs(result) do
-- 			local include_dir = line:gsub("-I", "") -- Entferne das -I Präfix
-- 			if include_dir ~= "" then
-- 				table.insert(include_dirs, include_dir)
-- 			end
-- 		end
-- 	end
--
-- 	return include_dirs
-- end
--
-- -- Dynamische Suche in allen Include-Pfaden von pkg-config
-- function M.search_dynamic_includes()
-- 	-- Rufe alle Include-Pfade mit pkg-config ab
-- 	local search_dirs = get_all_pkgconfig_includes()
--
-- 	-- Starte die Telescope-Suche in allen dynamisch ermittelten Include-Verzeichnissen
-- 	builtin.find_files({
-- 		prompt_title = "Search All Includes from pkg-config",
-- 		search_dirs = search_dirs,
-- 		file_ignore_patterns = { "%.cpp$", "%.c$", "%.o$", "%.so$", "%.a$", "%.la$" },
-- 	})
-- end
--
-- return M

local builtin = require("telescope.builtin")

local M = {}

-- Funktion für die Suche in den C++ Standard-Includes
function M.search_standard_includes()
	builtin.find_files({
		prompt_title = "Search C++ Standard Includes",
		search_dirs = { "/usr/include", "/usr/include/c++", "/usr/include/glib-2.0" },
		file_ignore_patterns = { "%.cpp$", "%.c$", "%.o$", "%.so$" },
	})
end

return M
