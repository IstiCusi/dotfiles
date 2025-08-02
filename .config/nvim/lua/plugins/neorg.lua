return {
	{
		"nvim-neorg/neorg",
		enabled = true,
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.dirman"] = {
						config = {
							default_workspace = "notes",
							workspaces = {
								notes = "~/Development/norg_notes",
							},
							index = "index.norg",
							use_popup = true,
						},
					},
					["core.summary"] = {},
					["core.tangle"] = {
						config = {
							tangle_on_write = true,
						},
					},
					["core.concealer"] = {
						config = {
              -- folds = false,
						},
					},
					["core.itero"] = {},
					["core.promo"] = {},
					["core.qol.toc"] = {},
					["core.qol.todo_items"] = {},
					["core.export"] = {},
					["core.esupports.metagen"] = {
						config = {
							update_date = false,
						},
					},
				},
			})
		end,
	},
}

