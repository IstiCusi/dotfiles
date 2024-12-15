local M = {}

local function set_project_path(filetype, system_paths, suffixes)
	local project_root = vim.fn.getcwd()
	local current_path = project_root .. "/**," .. table.concat(system_paths, ",") .. "/**"
	vim.opt_local.path = current_path
	for _, suffix in ipairs(suffixes) do
		vim.opt_local.suffixesadd:append(suffix)
	end
end

M.setup_lua_autocmds = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		callback = function()
			local system_paths = { vim.fn.stdpath("config") .. "/lua" }
			local suffixes = { ".lua", "init.lua" }
			set_project_path("lua", system_paths, suffixes)
		end,
	})
end

return M
