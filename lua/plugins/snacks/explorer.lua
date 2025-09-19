return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      matcher = {
        fuzzy = true,
      },
      win = {
        list = {
          keys = {
            ["l"] = "",
            ["o"] = "", -- open with system application
            ["P"] = "",
            ["<c-t>"] = "",

            -- defaults
            -- ["<BS>"] = "explorer_up",
            -- ["h"] = "explorer_close", -- close directory
            -- ["a"] = "explorer_add",
            -- ["d"] = "explorer_del",
            -- ["r"] = "explorer_rename",
            -- ["c"] = "explorer_copy",
            -- ["m"] = "explorer_move",
            -- ["y"] = { "explorer_yank", mode = { "n", "x" } },
            -- ["p"] = "explorer_paste",
            -- ["u"] = "explorer_update",
            -- ["<c-c>"] = "tcd",
            -- ["<leader>/"] = "picker_grep",
            -- ["."] = "explorer_focus",
            -- ["I"] = "toggle_ignored",
            -- ["H"] = "toggle_hidden",
            -- ["Z"] = "explorer_close_all",
            -- ["]g"] = "explorer_git_next",
            -- ["[g"] = "explorer_git_prev",
            -- ["]d"] = "explorer_diagnostic_next",
            -- ["[d"] = "explorer_diagnostic_prev",
            -- ["]w"] = "explorer_warn_next",
            -- ["[w"] = "explorer_warn_prev",
            -- ["]e"] = "explorer_error_next",
            -- ["[e"] = "explorer_error_prev",
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
