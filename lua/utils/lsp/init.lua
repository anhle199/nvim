local M = {}

M.diagnostic_config = function()
  local x = vim.diagnostic.severity

  vim.diagnostic.config({
    virtual_text = { prefix = "" },
    signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
    underline = true,
    float = { border = "single" },
  })
end

---@param method string|string[]
M.has = function(client, buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(client, buffer, m) then
        return true
      end
    end
    return false
  end

  method = method:find("/") and method or "textDocument/" .. method
  if client.supports_method(method) then
    return true
  end

  return false
end

return M
