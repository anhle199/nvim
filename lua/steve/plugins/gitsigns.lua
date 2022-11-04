local status, gitsigns = pcall(require, "gitsigns")
if not status then return end

gitsigns.setup()


--------------------------------------------
--                 KEY MAPPINGS           --
--------------------------------------------
local Utils = require("steve.core.utils")
local nnoremap = Utils.nnoremap

nnoremap("<Space>gd", ":Gitsigns diffthis<CR>")
nnoremap("<Space>gb", ":Gitsigns blame_line<CR>")
