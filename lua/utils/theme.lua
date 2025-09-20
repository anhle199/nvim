---@class utils.theme
local M = {}

local config_path = vim.fn.stdpath("config") .. "/config.json"

-- @return false, nil on failure
-- @return true, table on success
local function read_config_file()
  -- Read the file contents
  local file = io.open(config_path, "r")
  if not file then
    vim.notify("Could not open file: " .. config_path, vim.log.levels.ERROR)
    return false, nil
  end
  local content = file:read("*a")
  file:close()

  -- Decode JSON string to Lua table
  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Failed to parse JSON: " .. data, vim.log.levels.ERROR)
    return false, nil
  end
  return true, data
end

--- @param config table
--- @return boolean
local function save_config_file(config)
  -- Convert table to JSON string
  local ok, json = pcall(vim.json.encode, config)
  if not ok then
    vim.notify("Failed to encode config to JSON", vim.log.levels.ERROR)
    return false
  end

  -- Save JSON string to file
  local file = io.open(config_path, "w")
  if file then
    file:write(json)
    file:close()
    vim.notify("Config saved to: " .. config_path)
    return true
  else
    vim.notify("Failed to open file for writing: " .. config_path, vim.log.levels.ERROR)
    return false
  end
end

M.toggle_theme = function()
  local read_ok, config = read_config_file()
  if not read_ok then
    return
  end

  if config == nil then
    config = {}
  end

  local new_bg = config.background == "dark" and "light" or "dark"
  config.background = new_bg
  local save_ok = save_config_file(config)

  if save_ok then
    vim.opt.background = new_bg
  end
end

M.refresh_background_from_config = function()
  local read_ok, config = read_config_file()
  if not read_ok or config == nil then
    return
  end

  if config == nil then
    return
  end

  local bg = config.background == "light" and "light" or "dark"
  vim.opt.background = bg
end

return M
