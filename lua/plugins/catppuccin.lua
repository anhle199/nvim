return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "auto",   -- latte, frappe, macchiato, mocha
    background = {      -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,   -- disables setting the background color.
    styles = {                        -- Handles the styles of general hi groups (see `:h highlight-args`):
      conditionals = {},
    },
  }
}
