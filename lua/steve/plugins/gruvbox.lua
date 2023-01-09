local status, gruvbox = pcall(require, 'gruvbox')
if not status then return end

gruvbox.setup {
  undercurl = true,
  underline = true,
  bold = true,
  italic = false,
  inverse = true,
  contrast = "hard",
  dim_inactive = false,
  transparent_mode = false,
}
