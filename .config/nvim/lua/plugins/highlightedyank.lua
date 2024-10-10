return {
	"machakann/vim-highlightedyank",
	config = function()
		vim.g.highlightedyank_highlight_duration = 300
		vim.api.nvim_set_hl(0, "HighlightedyankRegion", {
			fg = "None",
			bg = "#350094",
			underline = false,
		})
	end,
}
