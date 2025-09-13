return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "Telescope",
  opts = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local state = require("telescope.state")
    local layout_strats = require("telescope.pickers.layout_strategies")
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")

    local disable_preview_on_binary_file_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end,
      }):sync()
    end

    local toggle_layout_preview = function(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local status = state.get_status(picker.prompt_bufnr)

      local is_show_preview = false
      local preview_winid = status.layout.preview and status.layout.preview.winid
      if picker.previewer and preview_winid then
        picker.hidden_previewer = picker.previewer
        picker.previewer = nil
        is_show_preview = false
      elseif picker.hidden_previewer and not preview_winid then
        picker.previewer = picker.hidden_previewer
        picker.hidden_previewer = nil
        is_show_preview = true
      else
        return
      end

      picker.layout_config = picker.layout_config or {}
      picker.layout_config[picker.layout_strategy] = picker.layout_config[picker.layout_strategy] or {}
      -- flex layout is weird and needs handling separately
      if picker.layout_strategy == "flex" then
        picker.layout_config.flex.horizontal = picker.layout_config.flex.horizontal or {}
        picker.layout_config.flex.vertical = picker.layout_config.flex.vertical or {}
        local old_pos = vim.F.if_nil(
          picker.layout_config.flex[picker.__flex_strategy].prompt_position,
          picker.layout_config[picker.__flex_strategy].prompt_position
        )
        local new_pos = old_pos == "top" and "bottom" or "top"
        picker.layout_config[picker.__flex_strategy].prompt_position = new_pos
        picker.layout_config.flex[picker.__flex_strategy].prompt_position = new_pos
      elseif layout_strats._configurations[picker.layout_strategy].prompt_position then
        local width = is_show_preview and 0.9 or 0.5
        picker.layout_config.width = width
        picker.layout_config[picker.layout_strategy].width = width

        local height = is_show_preview and 0.9 or 0.6
        picker.layout_config.height = height
        picker.layout_config[picker.layout_strategy].height = height
      end

      picker:full_layout_update()
    end

    local find_command = function()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = " 󰍉 ",
        selection_caret = " ",
        entry_prefix = " ",
        file_ignore_patterns = { "node_modules", "dist", "__pycache__", "build" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.6,
          },
          width = 0.5,
          height = 0.6,
        },
        preview = {
          filesize_limit = 1,   -- MB
          highlight_limit = 0.1,
          hide_on_startup = true,
        },
        buffer_previewer_maker = disable_preview_on_binary_file_maker,
        default_mappings = {},   -- remove all default mappings
        mappings = {
          n = {
            ["<LeftMouse>"] = {
              actions.mouse_click,
              type = "action",
              opts = { expr = true },
            },
            ["<2-LeftMouse>"] = {
              actions.double_mouse_click,
              type = "action",
              opts = { expr = true },
            },

            ["<ESC>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["<a-j>"] = actions.move_selection_next,
            ["<a-k>"] = actions.move_selection_previous,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-f>"] = actions.preview_scrolling_left,
            ["<C-k>"] = actions.preview_scrolling_right,

            -- toggling
            ["<C-p>"] = toggle_layout_preview,

            ["?"] = actions.which_key,
          },
          i = {
            --["<a-i>"] = find_files_no_ignore,
            --["<a-h>"] = find_files_with_hidden,

            ["<LeftMouse>"] = {
              actions.mouse_click,
              type = "action",
              opts = { expr = true },
            },
            ["<2-LeftMouse>"] = {
              actions.double_mouse_click,
              type = "action",
              opts = { expr = true },
            },

            ["<a-j>"] = actions.move_selection_next,
            ["<a-k>"] = actions.move_selection_previous,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-f>"] = actions.preview_scrolling_left,
            ["<C-k>"] = actions.preview_scrolling_right,

            ["<C-p>"] = toggle_layout_preview,

            -- disable c-j because we dont want to allow new lines #2123
            ["<C-j>"] = actions.nop,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
