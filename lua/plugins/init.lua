return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- file manager
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require("config.nvimtree"),
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require("config.gitsigns"),
  },
}