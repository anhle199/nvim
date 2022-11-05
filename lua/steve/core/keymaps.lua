local Utils = require('steve.core.utils')
local nnoremap = Utils.nnoremap -- normal noremap
local inoremap = Utils.inoremap -- insert noremap
local vnoremap = Utils.vnoremap -- visual/select noremap
local xnoremap = Utils.xnoremap -- visual noremap

-- Remap space as leader key
-- Modes: Normal, Visual, Select, Operator-pending
-- <Nop>: do nothing (useful in mappings)
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })


--------------------------------------------
--            BASE KEY MAPPINGS           --
--------------------------------------------
-- Reload configuration without restart nvim
nnoremap('<Space>r', ':so %<CR>')

-- Better delete one character using 'x'
nnoremap('x', '"_x')

-- Enable backspace to delete selected area
vnoremap('<BS>', '"_d')

-- Using 'delete' key in insert mode
inoremap('<C-d>', '<Del>')

-- Better paste
vnoremap('p', '"_dP')

-- Press jk fast to exit insert mode
inoremap('jk', '<ESC>')

-- Saves current the buffer with ctrl + s
nnoremap('<Space>w', ':w<CR>')

-- Clear search highlighting with <Space> + c
nnoremap('<Space>c', ':nohl<CR>')

-- Close the current buffer
nnoremap('<Space>q', ':q<CR>')

-- Better window navigation
-- nnoremap('<C-h>', '<C-w>h')
-- nnoremap('<C-j>', '<C-w>j')
-- nnoremap('<C-k>', '<C-w>k')
-- nnoremap('<C-l>', '<C-w>l')

-- Better terminal navigation
--tnoremap('<C-h>', '<C-\\><C-N><C-w>h')
--tnoremap('<C-j>', '<C-\\><C-N><C-w>j')
--tnoremap('<C-k>', '<C-\\><C-N><C-w>k')
--tnoremap('<C-l>', '<C-\\><C-N><C-w>l')

-- Better movement in insert mode
--inoremap('<C-h>', '<Left>')
--inoremap('<C-j>', '<Down>')
--inoremap('<C-k>', '<Up>')
--inoremap('<C-l>', '<Right>')

-- Indent selected area and stay in indent mode
vnoremap('<', '<gv')
vnoremap('>', '>gv')

-- Move text up and down
xnoremap('J', ":move '>+1<CR>gv-gv")
xnoremap('K', ":move '<-2<CR>gv-gv")

-- Copy to system clippboard
nnoremap('<Space>y', '"+y')
vnoremap('<Space>y', '"+y')

-- Paste from system clippboard
nnoremap('<Space><C-v>', '"+p')
vnoremap('<Space><C-v>', '"+p')


nnoremap('<Space>f', ':Format<CR>')
