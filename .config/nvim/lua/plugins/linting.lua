return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- clangtidy soll compile_commands.json verwenden
		lint.linters.clangtidy = {
			cmd = "clang-tidy", -- Standard clang-tidy Befehl
			args = {
				"--quiet",
				"--compile-commands=./compile_commands.json", -- Datei aus dem Projektverzeichnis verwenden
			},
			stdin = false,
			stream = "stderr",
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat([[%E%f:%l:%c: %m]]),
		}

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			cpp = { "clangtidy" },
			c = { "clangtidy" },
			lua = { "luacheck" },
			java = { "checkstyle" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
