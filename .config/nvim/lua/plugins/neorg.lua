return {
	{
		"nvim-neorg/neorg",
		enabled = true,
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							default_workspace = "notes",
							workspaces = {
								notes = "~/Development/norg_notes",
							},
							index = "index.norg", -- The name of the main (root) .norg file
							use_popup = true,
						},
					},
					["core.summary"] = {},
          ["core.tangle"] = {
            config = {
              tangle_on_write = true,
            },
          },
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.itero"] = {}, -- <M-CR> to add header/list items
					["core.promo"] = {}, -- promotes/demotes headers, etc
					["core.qol.toc"] = {},
					["core.qol.todo_items"] = {},
					["core.export"] = {},
					-- https://github.com/nvim-neorg/neorg/wiki/Metagen
					["core.esupports.metagen"] = { config = { update_date = false } }, -- do not update date until https://github.com/nvim-neorg/neorg/issues/1579 fixed
				},
			})
		end,
	},
}
