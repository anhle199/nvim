local opt = vim.opt

-- General
vim.cmd("autocmd!")
opt.completeopt = { "menuone", "noinsert", "noselect" } -- Autocomplete options
opt.shortmess:append "sI" -- Disable nvim intro
opt.spelllang = "en_us"
opt.timeoutlen = 1000
opt.mouse = "" -- Disable mouse support

-- File format
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Processing file
opt.backup = false -- Creates a backup file
opt.writebackup = true -- Creates a backup file while it is being edited. The backup is removed after the file was successfully written
opt.swapfile = true -- Using swapfile: *.swp
opt.undofile = false -- Persistent undo (true: enable, false: disable)
-- enable: you are able to undo file after it is closed
-- the undofile is saved at "$XDG_STATE_HOME/nvim/undo/"

-- Theme, visibility
opt.title = true
opt.number = true -- Show line number
opt.relativenumber = true
opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default "foldmarker")
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background = "dark"
opt.cursorline = true
opt.laststatus = 3 -- Set global statusline
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 250 -- Max column for syntax highlight
opt.updatetime = 500 -- ms to wait for trigger an event
opt.showcmd = true
opt.cmdheight = 1
opt.pumheight = 10 -- Pop up menu height

-- Searching
opt.hlsearch = true -- Highlights search matches
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.wildignorecase = true -- Case-insensitive search with FZF
opt.path:append { "**" } -- Finding files - Search down into subfolders
opt.path:remove "/usr/include"
opt.wildignore:append { "node_modules", "dist", ".git", "**/node_modules/*", "**/dist/*", "**/.git/*" }

-- Indent, tab, space, line
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = true -- Wrap lines
opt.linebreak = true -- Wrap on word boundary
opt.breakindent = true
opt.backspace = { "start", "eol", "indent" } -- Enable "Backspace" key in insert mode


-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw",
  "netrwPlugin", "netrwSettings", "netrwFileHandlers", "matchit", "tar",
  "tarPlugin", "rrhelper", "spellfile_plugin", "vimball", "vimballPlugin",
  "zip", "zipPlugin", "tutor", "rplugin", "synmenu", "optwin", "compiler",
  "bugreport", "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
