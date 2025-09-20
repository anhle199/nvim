return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        preset = function()
          return vim.o.columns >= 120 and "ivy" or "vertical"
        end,
      },
      win = {
        input = {
          keys = {
            ["<c-s>"] = { "", mode = { "n", "i" } },
            ["<c-n>"] = { "", mode = { "n", "i" } },
            ["<c-p>"] = { "", mode = { "n", "i" } },
            ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
            ["<c-h>"] = { "edit_split", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<c-n>"] = "",
            ["<c-p>"] = "",
          },
        },
      },
      actions = {
        ---@param p snacks.Picker
        toggle_cwd = function(p)
          local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
          local current = p:cwd()
          p:set_cwd(current == root and cwd or root)
          p:find()
        end,
      },
      sources = {
        files = {
          hidden = true,
        },
        buffers = {
          hidden = true,
          win = {
            input = {
              keys = {
                ["<c-x>"] = { "", mode = { "n", "i" } },
              },
            },
          },
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- finder: <leader>f
    { "<leader>fw", function() Snacks.picker.grep() end,               desc = "Grep (Root Dir)" },
    { "<leader>ff", function() Snacks.picker.files() end,              desc = "Find Files (Root Dir)" },
    { "<leader>fl", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
    { "<leader>fb", function() Snacks.picker.buffers() end,            desc = "Buffers" },
    { "<leader>fp", function() Snacks.picker.projects() end,           desc = "Projects" },

    -- git: <leader>g
    { "<leader>gb", function() Snacks.picker.git_branches() end,       desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end,            desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end,         desc = "Git Status" },
    { "<leader>gd", function() Snacks.picker.git_diff() end,           desc = "Git Diff (Hunks)" },

    { "<leader>D",  function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    -- { "<leader>d",      function() Snacks.picker.diagnostics() end,                             desc = "Projet Diagnostics" },
  },
}
