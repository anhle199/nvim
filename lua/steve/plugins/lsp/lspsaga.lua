local status, saga = pcall(require, 'lspsaga')
if not status then return end

saga.init_lsp_saga {
  server_filetype_map = {},
  finder_action_keys = {
    open = {'o', '<CR>'},
    vsplit = '<C-v>',
    split = '<C-s>',
    tabe = '<C-t>',
    quit = {'q', '<ESC>'},
  },
  definition_action_keys = {
    edit = '<C-c>o',
    vsplit = '<C-v>',
    split = '<C-s>',
    tabe = '<C-t>',
    quit = {'q', '<ESC>'},
  },
  rename_action_quit = '<ESC>',
  rename_in_select = true,
}


-- Key mappings
local Utils = require('steve.core.utils')
local nnoremap = Utils.nnoremap

nnoremap('K', '<Cmd>Lspsaga hover_doc<CR>')
nnoremap('gca', '<Cmd>Lspsaga code_action<CR>')
nnoremap('grn', '<Cmd>Lspsaga rename<CR>')

-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
nnoremap('gs', '<Cmd>Lspsaga lsp_finder<CR>')

-- Diagnsotic jump can use `<c-o>` to jump back
nnoremap('<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
nnoremap('<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
nnoremap('<Space>d', '<Cmd>Lspsaga show_line_diagnostics<CR>')
