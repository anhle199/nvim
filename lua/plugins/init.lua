return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- file manager
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("config.nvim-tree")
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("config.gitsigns")
    end,
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

  -- formatting
  { 
    "stevearc/conform.nvim",
    opts = function()
      return require("config.conform")
    end,
  }, 

  -- lsp stuff
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts_extend = { "ensure_installed" },
    opts = function()
      return require("config.mason").options
    end, 
    config = function(_, opts)
      require("config.mason").override_configure(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("config.nvim-lspconfig").defaults()
    end,
  },
  

  -- { "nvim-telescope/telescope.nvim", opts = require "configs.telescope" },
  -- { "hrsh7th/nvim-cmp", opts = require "configs.cmp" },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("config.nvim-treesitter")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = function()
      return require("config.indent-blankline")
    end,
    main = "ibl",
  },
}
