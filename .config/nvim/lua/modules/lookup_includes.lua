local builtin = require('telescope.builtin')

local M = {}

-- Funktion für die Suche in den C++ Standard-Includes
function M.search_standard_includes()
  builtin.find_files({
    prompt_title = "Search C++ Standard Includes",
    search_dirs = { "/usr/include", "/usr/include/c++" },
    file_ignore_patterns = { "%.cpp$", "%.c$", "%.o$", "%.so$" },
  })
end

return M
