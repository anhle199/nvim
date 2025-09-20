_G.LazyVim = require("utils")

---@class LazyVimConfig: LazyVimOptions
local M = {}

---@type vim.wo|vim.bo
M._options = {
  indentexpr = vim.o.indentexpr,
  foldmethod = vim.o.foldmethod,
  foldexpr = vim.o.foldexpr,
}

LazyVim.config = M

---@class LazyVimOptions
local options = {
  ---@type string|fun()
  -- colorscheme = function()
  --   require("catppuccin").load()
  -- end,

  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    ft = {
      octo = "",
    },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = "󰌵 ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Namespace = "󰌗",
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰆧",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󱓻",
      File = "󰈚",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
      Table = "",
      Object = "󰅩",
      Tag = "",
      Array = "[]",
      Boolean = "",
      Number = "",
      Null = "󰟢",
      Supermaven = "",
      String = "󰉿",
      Calendar = "",
      Watch = "󰥔",
      Package = "",
      Copilot = "",
      Codeium = "",
      TabNine = "",
      BladeNav = "",
      Control = " ",
      Collapsed = " ",
      Key = " ",

      -- Array         = " ",
      -- Boolean       = "󰨙 ",
      -- Class         = " ",
      -- Codeium       = "󰘦 ",
      -- Color         = " ",
      -- Constant      = "󰏿 ",
      -- Constructor   = " ",
      -- Copilot       = " ",
      -- Enum          = " ",
      -- EnumMember    = " ",
      -- Event         = " ",
      -- Field         = " ",
      -- File          = " ",
      -- Folder        = " ",
      -- Function      = "󰊕 ",
      -- Interface     = " ",
      -- Keyword       = " ",
      -- Method        = "󰊕 ",
      -- Module        = " ",
      -- Namespace     = "󰦮 ",
      -- Null          = " ",
      -- Number        = "󰎠 ",
      -- Object        = " ",
      -- Operator      = " ",
      -- Package       = " ",
      -- Property      = " ",
      -- Reference     = " ",
      -- Snippet       = "󱄽 ",
      -- String        = " ",
      -- Struct        = "󰆼 ",
      -- Supermaven    = " ",
      -- TabNine       = "󰏚 ",
      -- Text          = " ",
      -- TypeParameter = " ",
      -- Unit          = " ",
      -- Value         = " ",
      -- Variable      = "󰀫 ",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
}

setmetatable(M, {
  __index = function(_, key)
    ---@cast options LazyVimConfig
    return options[key]
  end,
})

return M
