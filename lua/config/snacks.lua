local M = {}

M.config = function(opts)
  local notify = vim.notify
  require("snacks").setup(opts)
  -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
  -- this is needed to have early notifications show up in noice history
  if LazyVim.has("noice.nvim") then
    vim.notify = notify
  end
end

M.get_options = function()
  return {
    bigfile = {
      enabled = true,
      line_length = 5000,
    },
    quickfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false }, -- we set this in options.lua
    toggle = { map = LazyVim.safe_keymap_set },
    words = { enabled = true },
  }
end

M.get_keymaps = function()
  -- stylua: ignore
  return {
    { "<leader>.",  function() Snacks.scratch() end,          desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,   desc = "Select Scratch Buffer" },
    { "<leader>bd", function() Snacks.bufdelete() end,        desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end,  desc = "Delete Other Buffers" },
    { "<leader>+",  function() Snacks.zen.zoom() end,         desc = "Toggle Zoom" },
  }
end

return M
