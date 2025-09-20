return {
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
        float = {
          border = "single",
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      codelens = {
        enabled = false,
      },
      folds = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
          -- textDocument = {
          --   completion = {
          --     completionItem = {
          --       documentationFormat = { "markdown", "plaintext" },
          --       snippetSupport = true,
          --       preselectSupport = true,
          --       insertReplaceSupport = true,
          --       labelDetailsSupport = true,
          --       deprecatedSupport = true,
          --       commitCharactersSupport = true,
          --       tagSupport = { valueSet = { 1 } },
          --       resolveSupport = {
          --         properties = {
          --           "documentation",
          --           "detail",
          --           "additionalTextEdits",
          --         },
          --       },
          --     },
          --   },
          -- },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {},
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = vim.schedule_wrap(function(_, opts)
      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)

      -- inlay hints
      if opts.inlay_hints.enabled then
        LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- folds
      if opts.folds.enabled then
        LazyVim.lsp.on_supports_method("textDocument/foldingRange", function(client, buffer)
          if LazyVim.set_default("foldmethod", "expr") then
            LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
          end
        end)
      end

      -- code lens
      -- if opts.codelens.enabled and vim.lsp.codelens then
      --   LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
      --     vim.lsp.codelens.refresh()
      --     vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      --       buffer = buffer,
      --       callback = vim.lsp.codelens.refresh,
      --     })
      --   end)
      -- end

      -- diagnostics
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = LazyVim.config.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      if opts.capabilities then
        vim.lsp.config("*", { capabilities = opts.capabilities })
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason = LazyVim.has("mason-lspconfig.nvim")
      local mason_all = have_mason
          and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
        or {} --[[ @as string[] ]]

      local exclude_automatic_enable = {} ---@type string[]

      local function configure(server)
        local server_opts = opts.servers[server] or {}

        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, server_opts) then
          return true -- lsp will be setup by the setup function
        end

        vim.lsp.config(server, server_opts)

        -- manually enable if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(mason_all, server) then
          vim.lsp.enable(server)
          return true
        end
        return false
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(opts.servers) do
        server_opts = server_opts == true and {} or server_opts or false
        if server_opts and server_opts.enabled ~= false then
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if configure(server) then
            exclude_automatic_enable[#exclude_automatic_enable + 1] = server
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        else
          exclude_automatic_enable[#exclude_automatic_enable + 1] = server
        end
      end

      if have_mason then
        require("mason-lspconfig").setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          automatic_enable = {
            exclude = exclude_automatic_enable,
          },
        })
      end

      if vim.lsp.is_enabled and vim.lsp.is_enabled("denols") and vim.lsp.is_enabled("vtsls") then
        ---@param server string
        local resolve = function(server)
          local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
          vim.lsp.config(server, {
            root_dir = function(bufnr, on_dir)
              local is_deno = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) ~= nil
              if is_deno == (server == "denols") then
                if root_dir then
                  return root_dir(bufnr, on_dir)
                elseif type(markers) == "table" then
                  local root = vim.fs.root(bufnr, markers)
                  return root and on_dir(root)
                end
              end
            end,
          })
        end
        resolve("denols")
        resolve("vtsls")
      end
    end),
  },

  { import = "plugins.lsp.lang" }
}
