-- Keymap functions

local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = false, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.noremap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.exprnoremap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true, expr = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Useful mode-specific shortcuts
-- nomenclature: '<expr?><mode><nore?>map(lhs, rhs)' where:
--      'expr?' optional expr option
--      'nore?' optional no-remap option
--      modes = {
--        'n' = NORMAL,
--        'i' = INSERT,
--        'x' = VISUAL,
--        'v' = VISUAL + SELECT,
--        't' = TERMINAL,
--        'c' = COMMAND,
--      }

function M.imap(lhs, rhs, opt)
  M.map('i', lhs, rhs, opt)
end

function M.nnoremap(lhs, rhs, opts)
  M.noremap('n', lhs, rhs, opts)
end

function M.vnoremap(lhs, rhs, opts)
  M.noremap('v', lhs, rhs, opts)
end

function M.xnoremap(lhs, rhs, opts)
  M.noremap('x', lhs, rhs, opts)
end

function M.inoremap(lhs, rhs, opts)
  M.noremap('i', lhs, rhs, opts)
end

function M.exprnnoremap(lhs, rhs, opts)
  M.exprnoremap('n', lhs, rhs, opts)
end

function M.exprxnoremap(lhs, rhs, opts)
  M.exprnoremap('x', lhs, rhs, opts)
end

return M
