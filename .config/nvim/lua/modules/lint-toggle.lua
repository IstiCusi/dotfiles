--- TODO: Does not work
local M = {}

-- local lint = require("lint")
-- local lint_enabled = true
--
-- M.toggle_linting = function()
-- 	lint_enabled = not lint_enabled
-- 	if lint_enabled then
-- 		print("Linting aktiviert")
-- 	else
-- 		print("Linting deaktiviert")
-- 	end
-- end
--
-- local function conditional_lint()
-- 	if lint_enabled then
-- 		lint.try_lint()
-- 	else
-- 		print("Linting ist deaktiviert, überspringe Linting.")
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
-- 	callback = function()
-- 		conditional_lint()
-- 	end,
-- })
--
return M
