return {
	"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
	config = function()
		-- require("toggle_lsp_diagnostics").init()
		require("toggle_lsp_diagnostics").init({ start_on = false })
	end,
}
