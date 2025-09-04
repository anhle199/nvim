return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- file manager
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require("config.nvim-tree"),
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require("config.gitsigns"),
  },

  -- multiple cursors
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "User FilePost",
    config = function()
      require("config.multicursor")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = require("config.nvim-treesitter"),
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = require("config.indent-blankline"),
    main = "ibl",
  },
}
