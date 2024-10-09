
local comment_symbols = {
    lua = "--",
    python = "#",
    cpp = "//",
    c = "//",
    rust = "//",
    javascript = "//",
    bash = "#",
    html = "<!--",
    css = "/*",
    vim = "\"",
}

local M = {}


M.delete_comment = function()
    local filetype = vim.bo.filetype
    local comment_symbol = comment_symbols[filetype]

  if not comment_symbol then
        print("No comment symbol cefined for this Language in delete-comment.lua")
        return
    end


    local line = vim.api.nvim_get_current_line()


    local escaped_comment_symbol = vim.pesc(comment_symbol)


    local new_line = line:gsub("%s*" .. escaped_comment_symbol .. ".+$", "", 1)


    if new_line ~= line then
        vim.api.nvim_set_current_line(vim.trim(new_line))
    vim.cmd('normal! ==')
    else
        print("No Comment Found to Delete")
    end
end

return M
