local map = vim.keymap.set
local CmpUtils = require("utils.cmp")

map("i", "jk", "<ESC>")
map("n", ";", ":")
map("n", "<leader>w", "<cmd> w <cr>")
map("n", "<leader>q", "<cmd> q <cr>")
map("n", "<leader>l", "<cmd> Lazy <cr>")
map("v", "<BS>", '"_d')

-- clear search and stop snippet on escape
-- map("n", "<leader>ch", "<cmd>noh<CR>")
map(
  { "i", "n", "s" }, 
  "<esc>", 
  function()
    vim.cmd("noh")
    CmpUtils.actions.snippet_stop()
    return "<esc>"
  end,
  { expr = true }
)

-- indents
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

-- windows, same as tmux <leader> is <A-w>
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>v", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>x", "<C-W>c", { desc = "Delete Window", remap = true })

-- tabs
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<S-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })