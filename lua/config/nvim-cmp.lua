local cmp = require("cmp")
local cmp_types = require("cmp.types")
local autocomplete = { cmp_types.cmp.TriggerEvent.TextChanged }

return {
  completion = {
    completeopt = "menu,menuone",
    autocomplete = autocomplete,
  },
  view = {
    docs = {
      auto_open = false,
    },
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.visible_docs() then
        -- If documentation window is visible, close it
        cmp.close_docs()
      elseif cmp.visible() then
        -- If completion menu is visible but docs are not, open them
        cmp.open_docs()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<esc>"] = cmp.mapping.close(),

    -- toggle completion menu
    ["<c-space>"] = cmp.mapping(function(fallback)
      if autocomplete == false then
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      else
        fallback()
      end
    end, { "i" }),

    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.visible_docs() then
        -- If documentation window is visible, close it
        cmp.close_docs()
      end

      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.visible_docs() then
        -- If documentation window is visible, close it
        cmp.close_docs()
      end

      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "async_path" },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      local icons = LazyVim.config.icons.kinds
      if icons[item.kind] then
        --item.kind = icons[item.kind] .. item.kind
        item.kind = icons[item.kind] .. " "
      end

      local abbr_max_width = 60
      if item.abbr and #item.abbr > abbr_max_width then
        item.abbr = string.sub(item.abbr, 1, abbr_max_width) .. "…"
      end

      return item
    end,
  },

  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      zindex = 1001,
      scrolloff = 0,
      col_offset = 0,
      side_padding = 1,
      scrollbar = true,
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      zindex = 1001,
      max_width = 60,
    },
  },
}
