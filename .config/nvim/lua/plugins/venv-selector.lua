-- --- @param venv_path string A string containing the absolute path to selected virtualenv
-- --- @param venv_python string A string containing the absolute path to python binary in selected venv
-- local function changed_python(venv_path, venv_python)
-- 	local file = io.open("/tmp/venv_change.log", "a") -- /tmp ist ein Beispielpfad
-- 	file:write("changed_python wurde aufgerufen mit " .. venv_path .. "\n")
-- 	file:close()
-- 	vim.notify("Virtuelle Umgebung geändert auf: " .. venv_path, vim.log.levels.INFO)
-- end

return {
	"linux-cultist/venv-selector.nvim",
	-- dependencies = {
	-- 	"neovim/nvim-lspconfig",
	-- },
	branch = "regexp",
	config = function()
		require("venv-selector").setup({
			-- auto_refresh = true,
			-- changed_venv_hooks = { changed_python },
			settings = {
				find_code_venvs = {
					command = "fd '^python[0-9.]*$' ~/.pyenv/versions --type x --exclude '*/pkgs/*'",
				},
			},
			lsp_auto_setup = false,
		})
	end,
	keys = Phonon.venvKeys,
	-- keys = {
	-- 	{ "<leader>nv", "<cmd>VenvSelect<cr>" },
	-- },
}
