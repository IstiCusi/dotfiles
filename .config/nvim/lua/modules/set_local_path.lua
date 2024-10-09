---@diagnostic disable: unused-local
---

local M = {}

local function set_project_path(filetype, system_paths, suffixes)
  local project_root = vim.fn.getcwd() -- Holt das aktuelle Projektverzeichnis

  local current_path = project_root .. "/**," .. table.concat(system_paths, ',') .. "/**"
  vim.opt_local.path = current_path

  for _, suffix in ipairs(suffixes) do
    vim.opt_local.suffixesadd:append(suffix)
  end
end

local function get_python_package_paths()
  local python_exec = vim.fn.exepath('python')
  if python_exec == '' then
    print("Python executable not found")
    return {}
  end

  local python_paths = vim.fn.systemlist(python_exec .. " -c 'import site; print(site.getsitepackages())'")
  local system_paths = {}
  for _, path in ipairs(python_paths) do
    path = path:gsub("[%[%]']", "") 
    table.insert(system_paths, path)
  end

  return system_paths
end

local function get_cargo_project_root()
  local cargo_root = vim.fn.systemlist("cargo locate-project --workspace --message-format plain")[1]
  if not cargo_root or cargo_root == "" then
    print("Cargo project root not found")
    return nil
  end
  return vim.fn.fnamemodify(cargo_root, ":h")
end

M.setup_autocmds = function()

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
      local system_paths = { vim.fn.stdpath('config') .. '/lua' }
      local suffixes = { ".lua", "init.lua" }
      set_project_path("lua", system_paths, suffixes)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
      local system_paths = { "/usr/include", "/usr/local/include" }
      local suffixes = { ".h", ".hpp" }
      set_project_path("c_cpp", system_paths, suffixes)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
      local system_paths = get_python_package_paths() -- Hole Python-Paketpfade dynamisch
      local suffixes = { ".py" }
      set_project_path("python", system_paths, suffixes)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
      local cargo_root = get_cargo_project_root() -- Hole Cargo-Projekt-Root dynamisch
      if not cargo_root then
        return
      end
      local system_paths = { cargo_root, "/usr/lib/rustlib/src/rust/library" }
      local suffixes = { ".rs" }
      set_project_path("rust", system_paths, suffixes)
    end,
  })
end

return M

