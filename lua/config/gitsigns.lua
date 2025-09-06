return {
  signs = {
    delete = { text = "󰍵" },
    changedelete = { text = "󱕖" },
  },
  on_attach = function(buffer)
    local gs = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, "show blame current line")
    -- map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Blame Line")
    -- map("n", "<leader>gbb", gs.blame, "Blame Buffer")
  end,
}
