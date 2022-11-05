local status, lualine = pcall(require, 'lualine')
if not status then return end

local diff = {
	'diff',
	symbols = {
    added = ' ',
    modified = ' ',
    removed = ' '
  },
}

local filename = {
  'filename',
  path = 1,
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = {
    error = ' ',
    warn = ' ',
    info = ' ',
    hint = ' ',
  },
}

lualine.setup {
	options = {
		theme = 'onedark',
    disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
	},
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', diff },
    lualine_c = { filename },
    lualine_x = { diagnostics, 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
}
