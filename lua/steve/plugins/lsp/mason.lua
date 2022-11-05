local servers = {
  'sumneko_lua',
  'tsserver',
  'jsonls',
}

local settings = {
	ui = {
		border = 'none',
		icons = {
			package_installed = '◍',
			package_pending = '◍',
			package_uninstalled = '◍',
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require('mason').setup(settings)
require('mason-lspconfig').setup({
	automatic_installation = true,
})

local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end

local handlers = require('steve.plugins.lsp.handlers')

for _, server in pairs(servers) do
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	server = vim.split(server, '@')[1]

	local require_ok, conf_opts = pcall(require, 'steve.plugins.lsp.settings.' .. server)
	if require_ok then
		opts = vim.tbl_deep_extend('force', conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
