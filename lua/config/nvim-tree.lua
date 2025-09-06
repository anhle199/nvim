local function on_attach(buffer)
  local api = require("nvim-tree.api")

  -- default mappings
  api.config.mappings.default_on_attach(buffer)

  local function nomap(mode, lhs)
    vim.keymap.del(mode, lhs, { buffer = buffer })
  end

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      desc = desc,
      buffer = buffer,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end

  -- remove default mappings
  nomap("n", "g?")
  nomap("n", "<C-x>")
  nomap("n", "<tab>")

  map("n", "?", api.tree.toggle_help, "nvim tree: show help")
  map("n", "<C-h>", api.node.open.horizontal, "nvim tree: open in horizontal split")
end

return {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 40,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
      show = {
        git = true,
      },
    },
    group_empty = true,
    highlight_modified = "all",
  },
  git = {
    enable = true,
  },
  actions = {
    open_file = {
      window_picker = {
        chars = "1234567890",
      },
    },
  },
  on_attach = on_attach,
}
