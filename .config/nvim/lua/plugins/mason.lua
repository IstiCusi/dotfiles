return {

  "williamboman/mason.nvim",
  version = "1.11.0",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", version = "1.32.0" },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },



	-- "williamboman/mason.nvim",
	-- enabled = true,
 --  dependencies = {
 --    { "williamboman/mason-lspconfig.nvim", version = false },
 --    "WhoIsSethDaniel/mason-tool-installer.nvim",
 --  },
	-- dependencies = {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- },
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
      ensure_installed = {
        "pyright",
        "clangd",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "omnisharp"
      },
    })

    mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- JavaScript, TypeScript, etc. formatter
				"stylua", -- Lua formatter
				"isort", -- Python formatter
				"black", -- Python formatter
				"pylint", -- Python Linter
				"eslint_d", -- JavaScript/TypeScript Linter
				"clang-format", -- C/C++ formatter
				"rustfmt", -- Rust formatter
				"shfmt", -- Shell/Zsh formatter
				"google-java-format", -- Java formatter
				"rust-analyzer",
			},
		})
	end,
}
