local create_autogroup = vim.api.nvim_create_augroup  -- Create/get autocommand group
local create_autocmd = vim.api.nvim_create_autocmd    -- Create autocommand


--------------------------------------------------
--                   GENERAL                    --
--------------------------------------------------
create_autocmd({ 'FileType' }, {
	pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel' },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

create_autocmd({ 'VimResized' }, {
	callback = function()
		vim.cmd('tabdo wincmd =')
	end,
})

-- Remove whitespace on save
create_autocmd('BufWritePre', {
  pattern = '*',
  command = ':%s/\\s\\+$//e'
})


--------------------------------------------------
--                  YANK HIGHLIGHT              --
--------------------------------------------------
create_autogroup('YankHighlight', { clear = true })
create_autocmd({ 'TextYankPost' }, {
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
	end,
})


--------------------------------------------------
--                    ALPHA                     --
--------------------------------------------------
create_autocmd('User', {
  pattern = 'AlphaReady',
  command = 'set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2',
})



--------------------------------------------------
--                   TERMINAL                   --
--------------------------------------------------
-- -- Open a Terminal on the right tab
-- create_autocmd('CmdlineEnter', {
--   command = 'command! Term :botright vsplit term://$SHELL'
-- })
--
-- -- Enter insert mode when switching to terminal
-- create_autocmd('TermOpen', {
--   command = 'setlocal listchars= nonumber norelativenumber nocursorline',
-- })
-- create_autocmd('TermOpen', {
--   pattern = '*',
--   command = 'startinsert'
-- })
--
-- -- Close terminal buffer on process exit
-- create_autocmd('BufLeave', {
--   pattern = 'term://*',
--   command = 'stopinsert'
-- })
