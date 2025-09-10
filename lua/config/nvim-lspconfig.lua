local M = {}

local action_organize_imports = function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  })
end

-- export on_attach & capabilities
M.on_attach = function(client, buffer)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = "LSP " .. desc })
  end

  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  --map("n", "<leader>rn", require("utils.lsp.renamer"), "rename variable")
  map("n", "<leader>rf", function()
    vim.lsp.buf.references()
  end, "references")
  map("n", "<leader>d", function()
    vim.diagnostic.open_float()
  end, "floating diagnostic")
  map("n", "<leader>D", function()
    vim.diagnostic.setloclist()
  end, "diagnostic setloclist")
  map("n", "K", function()
    return vim.lsp.buf.hover()
  end, "Hover")

  if LazyVim.lsp.has(client, buffer, "definition") then
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  end

  if LazyVim.lsp.has(client, buffer, "codeAction") then
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

    if client.name == "vtsls" then
      map("n", "<leader>co", action_organize_imports, "organize imports")
    end

    if client.name == "pyright" then
      map("n", "<leader>co", action_organize_imports, "organize imports")
    end
  end

  if client.name == "pyright" then
    client.server_capabilities.hoverProvider = false
  end

  if client.name == "yamlls" then
    if vim.fn.has("nvim-0.10") == 0 then
      client.server_capabilities.documentFormattingProvider = true
    end
  end

  --{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
  --{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
  --{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
  --{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
  --{ "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
  --{ "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  --{ "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
  --{ "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight", desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
  --{ "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight", desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
  --{ "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight", desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
  --{ "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight", desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  LazyVim.lsp.diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      M.on_attach(client, args.buf)
    end,
  })

  local lua_lsp_settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          --vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  }
  local jsonls_settings = {
    json = {
      format = {
        enable = true,
      },
      validate = {
        enable = true,
      },
    },
  }
  local yamlls_settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
    },
  }
  --local pyright_settings = {
  --  python = {
  --    analysis = {
  --      typeCheckingMode = "off",
  --      diagnosticMode = "openFilesOnly",
  --      diagnosticSeverityOverrides = {
  --        reportImportCycles = "error",
  --        reportUnusedImport = "warning",
  --        reportUnusedClass = "warning",
  --        reportUnusedFunction = "warning",
  --        reportUnusedVariable = "warning",
  --        reportDuplicateImport = "error",
  --        reportUnnecessaryCast = "warning",
  --        reportUnnecessaryComparison = "warning",
  --        reportUnnecessaryContains = "warning",
  --      },
  --    },
  --  },
  --}
  -- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
  local vtsls_settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 100,
        },
      },
    },
    javasciprt = {},
    typescript = {
      tsserver = {
        maxTsServerMemory = 1024,
      },
      preferences = {
        includePackageJsonAutoImports = "off",
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        parameterNames = {
          enabled = "literals",
        },
        parameterTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = false,
        },
      },
    },
  }
  vtsls_settings.javascript = vtsls_settings.typescript

  --local gopls_settings = {
  --  -- gopls = {
  --  --   analyses = {
  --  --     unusedparams = true,
  --  --     unreachable = true,
  --  --   },
  --  --   staticcheck = true,
  --  -- },
  --  gopls = {
  --    gofumpt = true,
  --    -- codelenses = {
  --    --   gc_details = false,
  --    --   generate = true,
  --    --   regenerate_cgo = true,
  --    --   run_govulncheck = true,
  --    --   test = true,
  --    --   tidy = true,
  --    --   upgrade_dependency = true,
  --    --   vendor = true,
  --    -- },
  --    hints = {
  --      assignVariableTypes = true,
  --      compositeLiteralFields = true,
  --      compositeLiteralTypes = true,
  --      -- constantValues = true,
  --      functionTypeParameters = true,
  --      parameterNames = true,
  --      rangeVariableTypes = true,
  --    },
  --    analyses = {
  --      nilness = true,
  --      unusedparams = true,
  --      unusedwrite = true,
  --      useany = true,
  --    },
  --    usePlaceholders = true,
  --    -- completeUnimported = true,
  --    staticcheck = true,
  --    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
  --    semanticTokens = true,
  --  },
  --}

  -- Support 0.10 temporarily

  if vim.lsp.config then
    vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
    vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
    vim.lsp.config("vtsls", { settings = vtsls_settings })
    vim.lsp.config("jsonls", { settings = jsonls_settings })
    vim.lsp.config("yamlls", { settings = yamlls_settings })
    --vim.lsp.config("pyright", { settings = pyright_settings })
    --vim.lsp.config("gopls", { settings = gopls_settings })
    vim.lsp.enable({ "lua_ls", "html", "cssls", "vtsls", "jsonls", "yamlls" }) --, "pyright", "gopls" })
  else
    require("lspconfig").lua_ls.setup({
      capabilities = M.capabilities,
      on_init = M.on_init,
      settings = lua_lsp_settings,
    })
    require("lspconfig").vtsls.setup({ capabilities = M.capabilities, on_init = M.on_init, settings = vtsls_settings })
    require("lspconfig").jsonls.setup({ capabilities = M.capabilities, on_init = M.on_init, settings = jsonls_settings })
    require("lspconfig").yamlls.setup({ capabilities = M.capabilities, on_init = M.on_init, settings = yamlls_settings })
    --require("lspconfig").pyright.setup({ capabilities = M.capabilities, on_init = M.on_init, settings = pyright_settings })
    --require("lspconfig").gopls.setup({ capabilities = M.capabilities, on_init = M.on_init, settings = gopls_settings })

    require("lspconfig").html.setup({ capabilities = M.capabilities, on_init = M.on_init })
    require("lspconfig").cssls.setup({ capabilities = M.capabilities, on_init = M.on_init })
  end
end

return M
