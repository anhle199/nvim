local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  create_in_closed_folder = true,
  hijack_cursor = true,
  disable_netrw = true,
  open_on_setup = true,
  open_on_tab = true,
  prefer_startup_root = true,
  view = {
    width = 32,
    side = 'left',
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = false,
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '',
        folder = {
          arrow_closed = '',   -- 
          arrow_open   = '',   -- 
          default      = '',
          open         = '',
          empty        = '',
          empty_open   = '',
          symlink      = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  diagnostics = {
    enable = false,
  },
  actions = {
    expand_all = {
      max_folder_discovery = 300,
      exclude = { '.git', 'target', 'build', 'node_modules', 'dist', '__tests__', 'logs' },
    },
    remove_file = {
      close_window = true,
    },
    use_system_clipboard = true,
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}
