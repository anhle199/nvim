return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function() end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = LazyVim.config.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = function()
            return LazyVim.root.cwd():match("^.+/(.+)$")
          end,
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
        -- {
        --   filetype = "neo-tree",
        --   text = "Neo-tree",
        --   highlight = "Directory",
        --   text_align = "left",
        -- },
        {
          filetype = "snacks_layout_box",
        },
      },
      ---@param opts bufferline.IconFetcherOpts
      get_element_icon = function(opts)
        return LazyVim.config.icons.ft[opts.filetype]
      end,

      separator_style = "slope",
      indicator = {
        style = "underline",
      },
      max_name_length = 32,
      sort_by = 'insert_at_end',
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<tab>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<s-tab>",    "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  },
}
