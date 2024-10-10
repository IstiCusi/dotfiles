return {
	active = false,
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup()
	end,
}
