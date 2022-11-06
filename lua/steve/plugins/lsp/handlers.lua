local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = 'DiagnosticSignError', text = '' },
		{ name = 'DiagnosticSignWarn', text = '' },
		{ name = 'DiagnosticSignHint', text = '' },
		{ name = 'DiagnosticSignInfo', text = '' },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = 'minimal',
			border = 'rounded',
		},
	}

	vim.diagnostic.config(config)
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
  local function buf_set_nnoremap(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end

	-- buf_set_nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  -- buf_set_nnoremap('gca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
	-- buf_set_nnoremap('grn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
	buf_set_nnoremap('<Space>f', '<Cmd>lua vim.lsp.buf.format{ async = true }<CR>')

  -- buf_set_nnoremap('<C-j>', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
	-- buf_set_nnoremap('<C-k>', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
  -- buf_set_nnoremap('<Space>d', '<Cmd>lua vim.diagnostic.open_float()<CR>')
	buf_set_nnoremap('<Space>D', '<Cmd>lua vim.diagnostic.setloclist()<CR>')

	buf_set_nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
	buf_set_nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
	buf_set_nnoremap('gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
	buf_set_nnoremap('grf', '<Cmd>lua vim.lsp.buf.references()<CR>')
end

local function format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

local function lsp_format(bufnr)
  local lsp_format_group = vim.api.nvim_create_augroup('LspFormat', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = lsp_format_group,
    buffer = bufnr,
    callback = function()
      format(bufnr)
    end,
  })
end

M.on_attach = function(client, bufnr)
	if client.name == 'tsserver' then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == 'sumneko_lua' then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
  -- lsp_format(bufnr) -- format on save
end

return M
