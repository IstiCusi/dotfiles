return {
	{
		-- "alfaix/nvim-zoxide",
		dir = "~/.config/nvim/scripts/nvim-zoxide",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			define_commands = true, 
			path = "zoxide", 
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			extensions = { zoxide = {} },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("zoxide")
		end,
	},
}
