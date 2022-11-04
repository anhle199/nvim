local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
  local function buf_set_nnoremap(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
  end

	buf_set_nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	buf_set_nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	buf_set_nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	buf_set_nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	buf_set_nnoremap("grf", "<cmd>lua vim.lsp.buf.references()<CR>")
	buf_set_nnoremap("<Space>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
	buf_set_nnoremap("<Space>D", "<cmd>lua vim.diagnostic.setloclist()<CR>")
	buf_set_nnoremap("<C-j>", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>")
	buf_set_nnoremap("<C-k>", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>")
	buf_set_nnoremap("gca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	buf_set_nnoremap("grn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	buf_set_nnoremap("<Space>f", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>")
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      lsp_formatting(bufnr)
    end,
  })
end

return M
