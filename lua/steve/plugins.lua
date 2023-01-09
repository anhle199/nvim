local status, packer = pcall(require, 'packer')
if not status then
  print('Packer is not installed!!!')
  return
end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

-- This autocommand automatically run :PackerCompile whenever this file is updated
-- :PackerCompile - Regenerate compiled loader file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
  -- Commons
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Comments
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- supports JSX

  -- Auto close pairs, tags
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- Visibility
  use 'navarasu/onedark.nvim' -- theme/colorscheme
  use 'goolord/alpha-nvim' -- dashboard
  use 'nvim-lualine/lualine.nvim' -- statusline
  use { 'akinsho/bufferline.nvim', tag = 'v3.*' } -- tabbar
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'folke/zen-mode.nvim',
    disable = true,
  }
  use 'nvim-tree/nvim-tree.lua'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    disable = true,
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Completions
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  -- Snippets
  use 'L3MON4D3/LuaSnip' --snippet engine
  -- use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'williamboman/mason.nvim' -- simple to use language server installer
  use 'williamboman/mason-lspconfig.nvim' -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
  use 'glepnir/lspsaga.nvim' -- LSP UI

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
