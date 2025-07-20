vim.api.nvim_create_user_command("ClectiveSelect", function()
  require("clective").select_config()
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    local state_file = vim.fn.stdpath("config") .. "/scripts/clective/state.json"
    local f = io.open(state_file, "r")
    if f then
      local content = f:read("*a")
      f:close()
      local ok, result = pcall(vim.json.decode, content)
      if ok and result.active_config then
        require("clective").apply_config(result.active_config)
      end
    end
  end,
})
