local lfs = require("lfs")

-- Funktion zum Erstellen von Verzeichnissen rekursiv
local function mkdir_p(path)
	local path_sep = "/"
	local parts = {}
	for part in string.gmatch(path, "[^" .. path_sep .. "]+") do
		table.insert(parts, part)
		local subpath = table.concat(parts, path_sep)
		if not lfs.attributes(subpath) then
			lfs.mkdir(subpath)
		end
	end
end

-- Funktion zum Verarbeiten des Dateinamens und der Erweiterung
local function process_filename(link)
	-- Zerlege den Dateinamen und die Erweiterung am letzten Punkt (.)
	local name, ext = link:match("^(.*)%.(.*)$")

	-- Wenn keine Erweiterung vorhanden ist, gehe davon aus, dass es sich um einen einfachen Link handelt
	if not name or not ext then
		name = link
		ext = "norg" -- Standardmäßig wird die Erweiterung auf .norg gesetzt
	end

	-- Ersetze Leerzeichen durch Unterstriche im Dateinamen
	name = name:gsub("%s+", "_")

	-- Wenn die Erweiterung nicht .norg ist, hänge .norg an
	if ext ~= "norg" then
		ext = "norg"
	end

	-- Rückgabe des Dateinamens mit der korrekten Erweiterung
	return name .. "." .. ext
end

-- Funktion zum Konvertieren einer VimWiki-Datei (.wiki) zu Neorg
local function convert_file(vimwiki_file, neorg_file)
	print("Konvertiere Datei: " .. vimwiki_file)

	local input = io.open(vimwiki_file, "r")
	if input == nil then
		print("Fehler beim Öffnen der Datei: " .. vimwiki_file)
		return
	end

	local content = input:read("*all")
	input:close()

	-- Debugging Ausgabe des Originalinhalts
	print("Originalinhalt der Datei:\n" .. content)

	-- Konvertierungen: VimWiki zu Neorg

	-- 1. Konvertiere Titel (VimWiki: = Title = -> Neorg: * Title)

	local converted_content = content:gsub("^%=%=%=%s*(.-)%s*%=%=%=", "*** %1")
	converted_content = converted_content:gsub("^%=%=%s*(.-)%s*%=%=", "** %1")
	converted_content = converted_content:gsub("^%=%s*(.-)%s*%=", "* %1")

	-- Debugging Ausgabe nach der Überschriftenkonvertierung
	print("Inhalt nach Überschriftenkonvertierung: " .. converted_content)

	-- 2. Konvertiere Links ohne Beschreibung ([[Link]] -> [[Link_with_underscores.norg | Link]])
	converted_content = converted_content:gsub("%[%[(.-)%]%]", function(link)
		local processed_link = process_filename(link)
		return "[[" .. processed_link .. " | " .. link .. "]]"
	end)

	-- Debugging Ausgabe nach der ersten Link-Konvertierung
	print("Inhalt nach Konvertierung der einfachen Links: " .. converted_content)

	-- 3. Konvertiere Links mit Beschreibung ([[Link|Description]] -> [[Link_with_underscores.norg | Original Description]])
	converted_content = converted_content:gsub("%[%[(.-)|(.-)%]%]", function(link, desc)
		local processed_link = process_filename(link)
		return "[[" .. processed_link .. " | " .. desc .. "]]"
	end)

	-- Debugging Ausgabe nach der zweiten Link-Konvertierung
	print("Inhalt nach Konvertierung der beschriebenen Links: " .. converted_content)

	-- Schreibe die konvertierte Datei ins Neorg-Format
	mkdir_p(neorg_file:match("(.+)/")) -- Erstelle Verzeichnisse, falls nicht vorhanden
	local output = io.open(neorg_file, "w")
	if output == nil then
		print("Fehler beim Schreiben in die Datei: " .. neorg_file)
		return
	end

	output:write(converted_content)
	output:close()

	print("Konvertierte Datei gespeichert: " .. neorg_file)
end

-- Funktion zum rekursiven Durchlaufen des VimWiki-Verzeichnisses
local function traverse_and_convert(vimwiki_root, neorg_root)
	for file in lfs.dir(vimwiki_root) do
		if file ~= "." and file ~= ".." then
			local vimwiki_path = vimwiki_root .. "/" .. file
			local neorg_path = neorg_root .. "/" .. file:gsub("%s+", "_")

			local attr = lfs.attributes(vimwiki_path)
			if attr.mode == "directory" then
				print("Betrete Verzeichnis: " .. vimwiki_path)
				-- Erstelle das entsprechende Verzeichnis im neuen Repo
				mkdir_p(neorg_path)
				-- Rekursiv in das Verzeichnis eintreten
				traverse_and_convert(vimwiki_path, neorg_path)
			elseif attr.mode == "file" and file:match("%.wiki$") then
				-- Konvertiere VimWiki-Datei zu Neorg-Datei, Dateinamen mit Unterstrichen
				neorg_path = neorg_path:gsub("%.wiki$", ".norg") -- Ändere die Dateiendung auf .norg
				convert_file(vimwiki_path, neorg_path)
			else
				print("Keine VimWiki-Datei: " .. vimwiki_path)
			end
		end
	end
end

-- Hauptfunktion, die das Skript startet
local function convert_vimwiki_to_neorg(vimwiki_root, neorg_root)
	if lfs.attributes(vimwiki_root, "mode") == "directory" and lfs.attributes(neorg_root, "mode") == "directory" then
		print("Beginne mit der Konvertierung von " .. vimwiki_root .. " nach " .. neorg_root)
		traverse_and_convert(vimwiki_root, neorg_root)
		print("Konvertierung abgeschlossen!")
	else
		print("Eines der angegebenen Verzeichnisse existiert nicht.")
	end
end

-- Beispiel-Aufruf
convert_vimwiki_to_neorg("/home/phonon/Development/vimwiki/", "/home/phonon/Development/norg_notes/")
