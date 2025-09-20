return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      win = {
        list = {
          keys = {
            ["l"] = "",
            ["o"] = "", -- open with system application
            ["P"] = "",
            ["<c-t>"] = "",
          },
        },
      },
    },
    picker = {
      sources = {
        explorer = {
          diagnostics = false,
          matcher = {
            fuzzy = true,
          },
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<c-n>",     function() Snacks.explorer() end, desc = "File Explorer" },
  },
}
