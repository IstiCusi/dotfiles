return {
	"IstiCusi/kicknvim",
	ft = "kickass",
	config = function()
		require("kicknvim").setup({
			kickass_path = "/home/phonon/Development/lang/C64-KickAssembler/KickAss.jar",
      kickass_man = true,
			keys = {
				assemble = "<leader>ka",
				run = "<leader>kr",
			},
		})
	end,
}
