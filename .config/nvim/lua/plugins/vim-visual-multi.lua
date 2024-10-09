return {
	"mg979/vim-visual-multi",
	branch = "master",
	config = function()
		for key, _ in pairs(vim.g.VM_maps) do
			if key ~= "Find Under" and key ~= "Find Subword Under" then
				vim.g.VM_maps[key] = ""
			end
		end
		vim.g.VM_maps = Phonon.VM_maps
	end,
}
