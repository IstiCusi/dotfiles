-- local M = {}
--
-- local function get_standard_include_paths(compiler)
-- 	local cmd = "echo | " .. compiler .. " -E -Wp,-v - 2>&1 | grep -A 20 '#include <...>'"
-- 	local output = vim.fn.systemlist(cmd)
-- 	local paths = {}
--
-- 	local capture = false
-- 	for _, line in ipairs(output) do
-- 		if line:match("#include <...> search starts here:") then
-- 			capture = true
-- 		elseif line:match("End of search list.") then
-- 			break
-- 		elseif capture then
-- 			table.insert(paths, vim.trim(line) .. "/**")
-- 		end
-- 	end
--
-- 	return paths
-- end
--
-- M.setup_c_cpp_autocmds = function()
-- 	local c_paths = get_standard_include_paths("gcc")
-- 	local cpp_paths = get_standard_include_paths("g++")
--
-- 	vim.api.nvim_create_autocmd("FileType", {
-- 		pattern = "c",
-- 		callback = function()
-- 			vim.opt_local.path = table.concat(c_paths, ",")
-- 			vim.opt_local.suffixesadd:append(".h")
-- 		end,
-- 	})
--
-- 	vim.api.nvim_create_autocmd("FileType", {
-- 		pattern = "cpp",
-- 		callback = function()
-- 			vim.opt_local.path = table.concat(cpp_paths, ",")
-- 			vim.opt_local.suffixesadd:append(".h")
-- 			vim.opt_local.suffixesadd:append(".hpp")
-- 		end,
-- 	})
-- end
--
-- return M


local M = {}

local function get_compile_commands_paths()
	local json_path = vim.fn.getcwd() .. "/compile_commands.json"
	if vim.fn.filereadable(json_path) == 1 then
		local paths = {}
		local json_data = vim.fn.json_decode(vim.fn.readfile(json_path))
		for _, entry in ipairs(json_data) do
			for _, flag in ipairs(vim.split(entry.command, " ")) do
				if flag:match("^-I") then
					table.insert(paths, flag:gsub("^-I", "") .. "/**")
				end
			end
		end
		return paths
	end
	return {}
end


local function get_standard_include_paths(compiler)
	local cmd = "echo | " .. compiler .. " -E -Wp,-v - 2>&1 | grep -A 20 '#include <...>'"
	local output = vim.fn.systemlist(cmd)
	local paths = {}

	local capture = false
	for _, line in ipairs(output) do
		if line:match("#include <...> search starts here:") then
			capture = true
		elseif line:match("End of search list.") then
			break
		elseif capture then
			table.insert(paths, vim.trim(line) .. "/**")
		end
	end

	-- Aktuellen Projektpfad hinzufügen
	table.insert(paths, vim.fn.expand("%:p:h") .. "/**")
  vim.list_extend(paths, get_compile_commands_paths())
	return paths
end

M.setup_c_cpp_autocmds = function()
	local c_paths = get_standard_include_paths("gcc")
	local cpp_paths = get_standard_include_paths("g++")

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "c",
		callback = function()
			vim.opt_local.path = table.concat(c_paths, ",")
			vim.opt_local.suffixesadd:append(".h")
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "cpp",
		callback = function()
			vim.opt_local.path = table.concat(cpp_paths, ",")
			vim.opt_local.suffixesadd:append(".h")
			vim.opt_local.suffixesadd:append(".hpp")
		end,
	})
end

return M
