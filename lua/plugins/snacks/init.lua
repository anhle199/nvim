return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
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
      styles = {
        notification = {
          wo = {
            wrap = true,
          },
        },
      },
    },
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if LazyVim.has("noice.nvim") then
        vim.notify = notify
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,         desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,  desc = "Select Scratch Buffer" },
      { "<leader>q",  function() Snacks.bufdelete() end,       desc = "Delete Buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<leader>+",  function() Snacks.zen.zoom() end,        desc = "Toggle Zoom" },
      {
        "<leader>n",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History"
      },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },

  { import = "plugins.snacks.picker" },
  { import = "plugins.snacks.explorer" },
}
