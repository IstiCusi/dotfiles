local M = {}

--- @param venv_path string A string containing the absolute path to selected virtualenv
--- @param venv_python string A string containing the absolute path to python binary in selected venv
-- function changed_python(venv_path, venv_python)
-- 	vim.notify("This is working", vim.log.levels.INFO)
-- end

local function get_python_package_paths()
	local python_exec = vim.fn.exepath("python")
	if python_exec == "" then
		print("Python executable not found")
		return {}
	end

	local python_paths = vim.fn.systemlist(python_exec .. " -c 'import site; print(site.getsitepackages())'")
	local system_paths = {}
	for _, path in ipairs(python_paths) do
		path = path:gsub("[%[%]']", "")
		table.insert(system_paths, path)
	end
	return system_paths
end

M.setup_python_autocmds = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function()
			local system_paths = get_python_package_paths()
			local suffixes = { ".py" }
			vim.opt_local.path = table.concat(system_paths, ",")
			for _, suffix in ipairs(suffixes) do
				vim.opt_local.suffixesadd:append(suffix)
			end
		end,
	})
end

return M
