local status, _ = pcall(require, 'lspconfig')
if not status then return end

require('steve.plugins.lsp.mason')
require('steve.plugins.lsp.handlers').setup()
require('steve.plugins.lsp.null-ls')
require('steve.plugins.lsp.lspsaga')
