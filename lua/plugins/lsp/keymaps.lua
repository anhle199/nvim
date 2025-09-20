local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end

  -- stylua: ignore
  M._keys = {
    -- { "gd",         vim.lsp.buf.definition,                    desc = "Goto Definition", has = "definition" },
    -- { "gr",         vim.lsp.buf.references,                    desc = "References",      nowait = true },
    -- { "gD",         vim.lsp.buf.declaration,                   desc = "Goto Declaration" },
    -- { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
    -- { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },

    { "K",          function() return vim.lsp.buf.hover() end,                                                   desc = "Hover" },
    { "<leader>ca", vim.lsp.buf.code_action,                                                                     desc = "Code Action",           mode = { "n", "v" },      has = "codeAction" },
    { "<leader>rn", vim.lsp.buf.rename,                                                                          desc = "Rename",                has = "rename" },
    { "<leader>cA", LazyVim.lsp.action.source,                                                                   desc = "Source Action",         has = "codeAction" },

    -- lsp: <leader>l or g
    { "gd",         function() Snacks.picker.lsp_definitions() end,                                              desc = "Goto Definition",       has = "definition" },
    { "gr",         function() Snacks.picker.lsp_references() end,                                               nowait = true,                  desc = "References" },
    { "gi",         function() Snacks.picker.lsp_implementations() end,                                          desc = "Goto Implementation" },
    { "gs",         function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end,           desc = "LSP Symbols",           has = "documentSymbol" },
    { "gS",         function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end,                                              desc = "Goto Definition",       has = "definition" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end,                                               nowait = true,                  desc = "References" },
    { "<leader>li", function() Snacks.picker.lsp_implementations() end,                                          desc = "Goto Implementation" },
    { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end,                                         desc = "Goto T[y]pe Definition" },
    { "<leader>ls", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end,           desc = "LSP Symbols",           has = "documentSymbol" },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
  }

  return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end
  return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = vim.tbl_extend("force", {}, M.get())
  local opts = LazyVim.opts("nvim-lspconfig")
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
