return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  version = "^1.0.0",
  opts_extend = { "ensure_installed" },
  opts = {
    PATH = "skip",

    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ",
      },
    },

    max_concurrent_installers = 10,

    ensure_installed = {
      -- lua dev
      "lua-language-server",
      "stylua",

      -- web dev
      "css-lsp",
      "html-lsp",
      "vtsls",
      "prettier",

      -- python dev
      -- "pyright",
      -- "black",
      -- "isort",

      -- others
      "json-lsp",
      "yaml-language-server",

      -- devops
      -- "docker-compose-language-service",
      -- "docker-language-server",
      -- "dockerfile-language-server",
      -- "ansible-language-server",
      -- "ansible-lint",
      -- "terraform",
      -- "terraform-ls",
      -- "tflint",
      -- "tfsec",

      -- database
      -- "pgformatter",
      -- "postgrestools",
      -- "sql-formatter",
      -- "sqlfluff",
      -- "sqlfmt",
      -- "sqlls",
      -- "sqls",

      -- go
      "gopls",
      "goimports",
      "gofumpt",
      -- "gomodifytags",
      -- "impl",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)

    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        -- local at_idx = string.find(tool, "@")
        -- local package_name = tool
        -- local version = nil
        --
        -- if at_idx ~= nil then
        --   package_name = string.sub(tool, 0, at_idx - 1)
        --   version = string.sub(tool, at_idx + 1)
        -- end

        -- local p = mr.get_package(package_name)
        -- if not p:is_installed() then
        --   p:install({ version = version })
        -- end

        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
