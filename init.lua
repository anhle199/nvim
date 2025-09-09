vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("options")
require("autocmds")
require("keymaps")

_G.LazyVim = require("utils")

local lazy_config = require("config.lazy")
require("lazy").setup("plugins", lazy_config)

vim.cmd.colorscheme("catppuccin")
require("utils.theme").refresh_background_from_config()

-- import multiple plugin directories
-- require("lazy").setup(
--   {
--     { import = "plugins1" },
--     { import = "plugins2" },
--   },
--   lazy_config
-- )
