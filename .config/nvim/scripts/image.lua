-- return {
--   "3rd/image.nvim",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   config = function()
--     require("image").setup {
--       backend = "kitty",  -- oder "ueberzug"
--       max_width = 80, max_height = 20, only_render_at_cursor = false,
--     }
--   end
-- }
--

-- return { "3rd/image.nvim",
-- 	dependencies = { "nvim-lua/plenary.nvim" },
-- 	lazy = true,
-- 	event = "BufEnter",
-- 	config = function()
-- 		require("image").setup({
-- 			backend = "kitty",
-- 			processor = "magick_cli",
-- 			max_width = 80,
-- 			max_height = 20,
-- 			only_render_at_cursor = false,
-- 			integrations = {
-- 				neorg = {
-- 					enabled = true,
-- 					filetypes = { "norg" },
-- 					clear_in_insert_mode = true,
-- 					download_remote_images = true,
-- 					-- ⚠️ KEIN "placement", ist nicht unterstützt
-- 				},
-- 			},
-- 			window_overlap_clear_enabled = true,
-- 		})
-- 	end,
-- }

-- return {
--   "3rd/image.nvim",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   event = "VeryLazy", -- oder z. B. "BufEnter" bei Bedarf
--   config = function()
--     require("image").setup {
--       backend = "kitty",
--       processor = "magick_cli",
--       max_width = 80,
--       max_height = 20,
--       only_render_at_cursor = false,
--       integrations = {
--         neorg = {
--           enabled = true,
--           filetypes = { "norg" },
--           clear_in_insert_mode = true,
--           download_remote_images = true,
--         },
--       },
--       window_overlap_clear_enabled = true,
--     }
--   end
-- }

-- return {
--   "3rd/image.nvim",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   event = "VeryLazy",  -- Plugin verzögert laden
--   config = function()
--     require("image").setup {
--       backend = "kitty",
--       processor = "magick_cli",
--       integrations = {
--         neorg = { enabled = true, filetypes = { "norg" }, clear_in_insert_mode = true, download_remote_images = true },
--       },
--       max_width = 80,
--       max_height = 20,
--       only_render_at_cursor = false,
--       window_overlap_clear_enabled = true,
--     }
--   end
-- }


-- return {
--   "3rd/image.nvim",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   event = "VeryLazy",  -- wichtig: NICHT config sofort ausführen!
--   config = function()
--     local ok, image = pcall(require, "image")
--     if not ok then
--       vim.notify("image.nvim failed to load", vim.log.levels.WARN)
--       return
--     end
--
--     local status_ok, err = pcall(function()
--       image.setup {
--         backend = "kitty",
--         processor = "magick_cli",
--         max_width = 80,
--         max_height = 20,
--         only_render_at_cursor = false,
--         integrations = {
--           neorg = {
--             enabled = true,
--             filetypes = { "norg" },
--             clear_in_insert_mode = true,
--             download_remote_images = true,
--           },
--         },
--         window_overlap_clear_enabled = true,
--       }
--     end)
--
--     if not status_ok then
--       vim.notify("image.nvim setup failed: " .. err, vim.log.levels.ERROR)
--     end
--   end,
-- }
--
return {
  "3rd/image.nvim",
  ft = { "norg" }, -- ← wird nur bei .norg-Dateien geladen
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local ok, image = pcall(require, "image")
    if not ok then
      vim.notify("image.nvim konnte nicht geladen werden", vim.log.levels.WARN)
      return
    end

    local success, err = pcall(function()
      image.setup {
        backend = "kitty",
        processor = "magick_cli",
        max_width = 80,
        max_height = 20,
        only_render_at_cursor = false,
        integrations = {
          neorg = {
            enabled = true,
            filetypes = { "norg" },
            clear_in_insert_mode = true,
            download_remote_images = true,
          },
        },
        window_overlap_clear_enabled = true,
      }
    end)

    if not success then
      vim.notify("image.nvim setup fehlgeschlagen: " .. err, vim.log.levels.ERROR)
    end
  end,
}
