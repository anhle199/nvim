local status, commenter = pcall(require, 'Comment')
if not status then return end

commenter.setup {
  mappings = {
    basic = false,
    extra = false,
  },
  -- JSX support
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}


--------------------------------------------
--               KEY MAPPINGS             --
--------------------------------------------
local Utils = require('steve.core.utils')
local nnoremap = Utils.nnoremap
local xnoremap = Utils.xnoremap

-- Comment the current line in normal mode
nnoremap('gcc', '<Plug>(comment_toggle_linewise_current)')
nnoremap('gbc', '<Plug>(comment_toggle_blockwise_current)')

-- Comment the block line in visual mode
xnoremap('gcc', '<Plug>(comment_toggle_linewise_visual)')
xnoremap('gbc', '<Plug>(comment_toggle_blockwise_visual)')
