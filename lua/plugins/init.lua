return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "config.nvimtree"
    end,
  },
}