return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "User FilePost",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    --- @param dir -1|1 Direction
    local lineAddCursor = function(dir)
      local top, bot
      mc.action(function(ctx)
        top = ctx:mainCursor() == ctx:firstCursor()
        bot = ctx:mainCursor() == ctx:lastCursor()
      end)
      if top == bot or (top and dir == -1) or (bot and dir == 1) then
        mc.lineAddCursor(dir)
      else
        mc.deleteCursor()
      end
    end

    local map = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    map({ "n", "v", "x" }, "<s-down>", function()
      lineAddCursor(1)
    end, { desc = "Add cursor below" })
    map({ "n", "v", "x" }, "<s-up>", function()
      lineAddCursor(-1)
    end, { desc = "Add cursor above" })

    -- Add or skip adding a new cursor by matching word/selection
    map({ "n", "x" }, "<c-d>", function()
      mc.matchAddCursor(1)
    end, { desc = "Match add cursor above" })
    -- set({ "n", "x" }, "<c-s-d>", function() mc.matchAddCursor(-1) end, { desc = 'Match add cursor below' })
    map({ "n", "x" }, "<c-a>", mc.matchAllAddCursors, { desc = "Match all add cursors word/selection" })

    -- Add and remove cursors with control + left click.
    map("n", "<c-leftmouse>", mc.handleMouse)
    map("n", "<c-leftdrag>", mc.handleMouseDrag)
    map("n", "<c-leftrelease>", mc.handleMouseRelease)

    map("n", "<leader>|", mc.alignCursors, { desc = "Align cursors" })
    map("x", "M", mc.matchCursors, { desc = "[M]atch cursors by regex" })
    map("x", "S", mc.splitCursors, { desc = "[S]plit cursors by regex" })
    map("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors" })

    -- Disable and enable cursors.
    map({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<s-left>", mc.prevCursor, { desc = "Jump prev cursor" })
      layerSet({ "n", "x" }, "<s-right>", mc.nextCursor, { desc = "Jump next cursor" })

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<s-x>", mc.deleteCursor, { desc = "Delete cursor" })

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
