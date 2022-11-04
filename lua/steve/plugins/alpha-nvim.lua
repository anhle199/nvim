local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")


-- Header
dashboard.section.header.val = {
  "                                                    ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                    ",
}


-- Menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
  dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
  dashboard.button("u", "ﮮ  Update plugins", ":PackerUpdate<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}


-- Footer
local function footer()
  local v = vim.version()
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return string.format("Le Hoang Anh  -   v%d.%d.%d  -  %s", v.major, v.minor, v.patch, datetime)
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true

-- Send config to alpha
alpha.setup(dashboard.opts)
