-- Mapping-Table für Dateitypen zu minted-Sprachen
local minted_language_map = {
	python = "python",
	rust = "rust",
	c = "c",
	cpp = "cpp",
	bash = "bash",
	javascript = "javascript",
	html = "html",
	css = "css",
	lua = "lua",
	java = "java",
	go = "go",
	haskell = "haskell",
	sql = "sql",
	yaml = "yaml",
	tex = "tex",
	markdown = "markdown",
	xml = "xml",
}

function print_with_minted()
	vim.cmd("write")

	local filetype = vim.bo.filetype
	local minted_language = minted_language_map[filetype]

	if not minted_language then
		print("Unsupported file type for printing.")
		return
	end

	local buffer_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

	local latex_template = [[
  \documentclass{article}
  \usepackage{minted}
  \usepackage[utf8]{inputenc}
  \usepackage{geometry}
  \geometry{a4paper, margin=1in}

  \begin{document}

  \begin{minted}[linenos]{]] .. minted_language .. [[}
  ]] .. buffer_content .. [[
  \end{minted}

  \end{document}
  ]]

	local latex_file = io.open("output.tex", "w")
	latex_file:write(latex_template)
	latex_file:close()

	vim.cmd("!pdflatex -shell-escape output.tex && lpr output.pdf")
end

-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>p",
-- 	":lua print_with_minted()<CR>",
-- 	{ desc = "Print", noremap = true, silent = true }
-- )
