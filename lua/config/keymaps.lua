-- tmux: session -> window -> pane
-- nvim: _______ -> tab    -> window -> buffer

local map = vim.keymap.set

map("i", "jk", "<ESC>", { desc = "exit insert mode" })
map("n", ";", ":", { desc = "enter command mode" })
map("n", "<leader>w", "<cmd> w <cr>", { desc = "save file changes" })
-- map("n", "<leader>q", "<cmd> q <cr>")
map("n", "<leader>l", "<cmd> Lazy <cr>")
map("v", "<BS>", '"_d')
map("x", "p", "'pgv\"' . v:register . 'y'", { remap = false, expr = true, desc = "past without replace clipboard" })

-- toggle background
-- dark -> catppuccin mocha
-- light -> catppuccin latte
map("n", "<leader>tt", function()
  LazyVim.theme.toggle_theme()
end)
-- refresh theme
map("n", "<leader>tr", function()
  LazyVim.theme.refresh_background_from_config()
end)

-- clear search and stop snippet on escape
-- map("n", "<leader>ch", "<cmd>noh<CR>")
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true })

-- better indents
map("n", "<", "<<", { remap = true })
map("n", ">", ">>", { remap = true })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move lines
map("v", "J", ":move '>+1<cr>gv=gv")
map("v", "K", ":move '<-2<cr>gv=gv")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- buffers
-- map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "new buffer" })
-- map("n", "<leader>b[", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<leader>b]", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>v", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>x", "<C-W>c", { desc = "Delete Window", remap = true })

-- tabs
-- map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<S-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- floating window to find and select command

-- nvimtree
map("n", "<c-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- formatting
-- map({ "n", "x" }, "<leader>m", function()
--   require("conform").format({ lsp_fallback = true })
-- end)
map({ "n", "v", "x" }, "<leader>m", function()
  LazyVim.format({ force = true })
end)

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "search file contents and file names" })
map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "search text in current buffer" })
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", { desc = "find files with hidden" })
map("n", "<leader>fa", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "find all files" })

-- comment
map("n", "\\\\", "gcc", { desc = "toggle comment", remap = true })
map("v", "\\\\", "gc", { desc = "toggle comment", remap = true })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "floating diagnostic" })
map("n", "<leader>D", vim.diagnostic.setloclist, { desc = "diagnostic setloclist" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
