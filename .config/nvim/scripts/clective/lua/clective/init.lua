local M = {}

local uv = vim.loop
local api = vim.api
local fn = vim.fn

local config = require("clective.config")
local config_path = vim.fn.stdpath("config") .. "/scripts/clective"
local state_file = config_path .. "/state.json"

--- Read the state file and obtai the json interpretation of the file content
local function read_state()
  local file = io.open(state_file, "r")
  if not file then return nil end
  local content = file:read("*a")
  file:close()
  local ok, result = pcall(vim.json.decode, content)
  if ok then return result else return nil end
end

--- Writes the state of json encoded to the state file
--- @param state lua object representation of the state to save
local function write_state(state)
  vim.fn.mkdir(config_path, "p")
  local file = io.open(state_file, "w")
  if not file then return end
  file:write(vim.json.encode(state))
  file:close()
end

-- function M.apply_config(name)
--   local include_configs = config.include_configs
--   local path_entries = {}
--
--   local buf_path = vim.api.nvim_buf_get_name(0)
--   local cwd = vim.fn.fnamemodify(buf_path, ":p:h")
--
--   local flags_path = cwd .. "/compile_flags.txt"
--   local file = io.open(flags_path, "r")
--   if file then
--     for line in file:lines() do
--       if line:match("^-I") then
--         table.insert(path_entries, line:sub(3) .. "/**")
--       end
--     end
--     file:close()
--   end
--
--   local includes = include_configs[name]
--   if includes then
--     for _, dir in ipairs(includes) do
--       table.insert(path_entries, dir .. "/**")
--     end
--   end
--
--   local function scan_dirs(base)
--     local handle = uv.fs_scandir(base)
--     if not handle then return end
--     while true do
--       local name, type = uv.fs_scandir_next(handle)
--       if not name then break end
--       local full = base .. "/" .. name
--       if type == "directory" then
--         table.insert(path_entries, full .. "/**")
--         scan_dirs(full)
--       end
--     end
--   end
--
--   for _, path in ipairs(path_entries) do
--     scan_dirs(path:gsub("/%*%*$", ""))
--   end
--
--   vim.opt_local.path = table.concat(path_entries, ",")
--   vim.opt_local.suffixesadd:append({".h", ".hpp", ".hh", ".hxx", ".c", ".cpp", ".cc", ".cxx"})
--   write_state({ active_config = name })
-- end

-- Applies configuration with a given key name
function M.apply_config(name)
  local include_configs = config.include_configs
  local path_entries = {}

  local buf_path = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.fnamemodify(buf_path, ":p:h")

  local function normalize(p)
    return p:gsub("/+$", ""):gsub("/%*%*$", "") .. "/**"
  end

  -- compile_flags.txt
  local flags_path = cwd .. "/compile_flags.txt"
  local file = io.open(flags_path, "r")
  if file then
    for line in file:lines() do
      if line:match("^-I") then
        table.insert(path_entries, normalize(line:sub(3)))
      end
    end
    file:close()
  end

  -- config.include_configs
  local includes = include_configs[name]
  if includes then
    for _, dir in ipairs(includes) do
      table.insert(path_entries, normalize(dir))
    end
  end

  vim.opt_local.path = table.concat(path_entries, ",")
  vim.opt_local.suffixesadd:append({ ".h", ".hpp", ".hh", ".hxx", ".c", ".cpp", ".cc", ".cxx" })
  write_state({ active_config = name })
end


function M.select_config()
  local include_configs = config.include_configs
  local keys = {}
  for k, _ in pairs(include_configs) do
    table.insert(keys, k)
  end
  table.sort(keys)
  vim.ui.select(keys, { prompt = "Select Include Config:" }, function(choice)
    if choice then
      M.apply_config(choice)
    end
  end)
end

function M.setup(opts)
  config.merge(opts and opts.profiles)

  vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
      local file = io.open(state_file, "r")
      if not file then return end
      local content = file:read("*a")
      file:close()
      local ok, data = pcall(vim.json.decode, content)
      if ok and data and data.active_config then
        require("clective").apply_config(data.active_config)
      end
    end,
  })
end

return M
