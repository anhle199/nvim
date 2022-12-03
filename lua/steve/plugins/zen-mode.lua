local status, zenMode = pcall(require, 'zen-mode')
if not status then return end

zenMode.setup({
  window = {
    width = 0.8, -- 80%
  },
})


-- Key mappings
local Utils = require('steve.core.utils')
local nnoremap = Utils.nnoremap

nnoremap('<Space>z', '<Cmd>ZenMode<CR>')
