-- PERF: we don't need this lualine require madness 🤷
local lualine_require = require("lualine_require")
lualine_require.require = require

local icons = require("config.icons")

vim.o.laststatus = vim.g.lualine_laststatus

local opts = {
  options = {
    theme = "auto",
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },

    lualine_c = {
      { "filename", path = 1 },
      -- LazyVim.lualine.root_dir(),
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      -- { LazyVim.lualine.pretty_path() },
    },
    lualine_x = {
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    },
    lualine_y = {
      { "progress", separator = " ", padding = { left = 1, right = 0 } },
      { "location", padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      -- function()
      --   return " " .. os.date("%R")
      -- end,
    },
  },
  extensions = { "lazy" },
}

-- do not add trouble symbols if aerial is enabled
-- And allow it to be overriden for some buffer types (see autocmds)
if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
  local trouble = require("trouble")
  local symbols = trouble.statusline({
    mode = "symbols",
    groups = {},
    title = false,
    filter = { range = true },
    format = "{kind_icon}{symbol.name:Normal}",
    hl_group = "lualine_c_normal",
  })
  table.insert(opts.sections.lualine_c, {
    symbols and symbols.get,
    cond = function()
      return vim.b.trouble_lualine ~= false and symbols.has()
    end,
  })
end

return opts
