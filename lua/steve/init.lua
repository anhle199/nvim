local has_platform = function(p)
  return vim.fn.has(p) == 1
end

local is_mac = has_platform('macunix')
local is_win = has_platform('win32')

-- load base configurations
require('steve.core.options')
require('steve.core.keymaps')
require('steve.core.autocommands')

-- load configurations for specific platform
if is_mac then
  require('steve.core.macos')
elseif is_win then
  require('steve.core.windows')
end

-- load plugin configurations
require('steve.plugins')
require('steve.plugins.onedark')
require('steve.plugins.alpha-nvim')
require('steve.plugins.lualine')
require('steve.plugins.bufferline')
require('steve.plugins.comment')
require('steve.plugins.nvim-treesitter')
require('steve.plugins.nvim-autopairs')
require('steve.plugins.nvim-ts-autotag')
require('steve.plugins.telescope')
require('steve.plugins.gitsigns')
require('steve.plugins.nvim-cmp')
require('steve.plugins.lsp')
require('steve.plugins.indent_blankline')
require('steve.plugins.zen-mode')
-- require('steve.plugins.nvim-tree')

vim.api.nvim_command 'colorscheme onedark'
