local status, bufferline = pcall(require, 'bufferline')
if not status then return end

bufferline.setup {
  options = {
    mode = 'tabs',
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    tab_size = 24,
    max_name_length = 24,
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'Tabline' },
    },
    buffer_selected = {
      fg = '#04d42a',
      bold = true,
      italic = true,
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'Tabline' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'Tabline' },
    },
  },
}


--------------------------------------------
--                KEY MAPPINGS            --
--------------------------------------------
local Utils = require('steve.core.utils')
local nnoremap = Utils.nnoremap

nnoremap('<Tab>', ':BufferLineCycleNext<CR>')
nnoremap('<S-Tab>', ':BufferLineCyclePrev<CR>')
