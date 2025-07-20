-- return {
--   "nvim-telescope/telescope.nvim",
--   tag = '0.1.8',
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
--     "nvim-tree/nvim-web-devicons",
--     "folke/todo-comments.nvim",
--   },
--   config = function()
--     local telescope = require("telescope")
--     local actions = require("telescope.actions")
--     local transform_mod = require("telescope.actions.mt").transform_mod
--
--     local trouble = require("trouble")
--     local trouble_telescope = require("trouble.sources.telescope")
--
--     local custom_actions = transform_mod({
--       open_trouble_qflist = function(prompt_bufnr)
--         trouble.toggle("quickfix")
--       end,
--     })
--
--     telescope.setup({
--       defaults = {
--         path_display = { "smart" },
--         mappings = {
--           i = {
--             ["<C-k>"] = actions.move_selection_previous,
--             ["<C-j>"] = actions.move_selection_next,
--             ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
--             ["<C-t>"] = trouble_telescope.open,
--           },
--         },
--       },
--     })
--
--     telescope.load_extension("fzf")
--     Phonon.telescopeKeys()
--   end,
-- }
--

-- plugins-config/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	keys = Phonon.telescope,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local mt = require("telescope.actions.mt")
		local transform = mt.transform_mod

		local trouble = require("trouble")
		local tt = require("trouble.sources.telescope")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + transform({
							open_trouble_qflist = function()
								trouble.toggle("quickfix")
							end,
						}),
						["<C-t>"] = tt.open,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
