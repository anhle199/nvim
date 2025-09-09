return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

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

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("config.luasnip")
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "https://codeberg.org/FelipeLema/cmp-async-path.git",
      },
    },
    opts = function()
      return require("config.nvim-cmp")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require("config.telescope")
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      return require("config.lualine")
    end,
  },

  -- others
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

  -- Automatically add closing tags for HTML and JSX
  -- {
  --   "windwp/nvim-ts-autotag",
  --   event = "LazyFile",
  --   opts = {},
  -- },
}
