-- macos
local trashCmd = "trash"

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local Tree = require("snacks.explorer.tree")
    local ExplorerActions = require("snacks.explorer.actions")

    return vim.tbl_deep_extend("force", opts or {}, {
      explorer = {},
      picker = {
        sources = {
          explorer = {
            diagnostics = false,
            matcher = {
              fuzzy = true,
            },
            win = {
              list = {
                keys = {
                  ["l"] = "",
                  ["o"] = "", -- open with system application
                  ["P"] = "",
                  ["<c-t>"] = "",
                },
              },
            },
            actions = {
              ---@param picker snacks.Picker
              explorer_del = function(picker)
                ---@type string[]
                local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
                if #paths == 0 then
                  return
                end
                local what = #paths == 1 and vim.fn.fnamemodify(paths[1], ":p:~:.") or #paths .. " files"
                ExplorerActions.confirm("Move to trash: " .. what .. "?", function()
                  local jobs = {}

                  for _, path in ipairs(paths) do
                    local normalizedPath = vim.fn.fnameescape(path)
                    local jobId = vim.fn.jobstart(trashCmd .. " " .. normalizedPath, {
                      detach = false,
                      on_stdout = function()
                        Snacks.bufdelete({ file = normalizedPath, force = true })
                        Snacks.notify.info("Moved `" .. normalizedPath .. "` to trash")
                      end,
                      on_stderror = function(_, data, _)
                        ---@type string[]
                        local err = {}
                        for _, line in ipairs(data) do
                          table.insert(err, line)
                        end
                        local joinedErr = table.concat(err, "\n")

                        Snacks.notify.error("Failed to move `" .. normalizedPath .. "` to trash:\n- " .. joinedErr)
                      end,
                      on_exit = function()
                        Tree:refresh(vim.fs.dirname(normalizedPath))
                      end,
                    })

                    table.insert(jobs, jobId)
                  end

                  vim.fn.jobwait(jobs)

                  picker.list:set_selected() -- clear selection
                  ExplorerActions.update(picker)
                end)
              end
            }
          },
        },
      },
    })
  end,
  -- stylua: ignore
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<c-n>",     function() Snacks.explorer() end, desc = "File Explorer" },
  },
}
