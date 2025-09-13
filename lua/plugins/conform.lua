return {
  "stevearc/conform.nvim",
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      json = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier", stop_after_first = true },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      markdown = { "prettier" },
      go = { "goimports", "gofumpt" },
    },
    formatters = {
      black = {
        prepend_args = { "--fast", "--line-length=120" },
      },
      isort = {
        prepend_args = { "--style=black" },
      },
      prettier = {
        -- This is the key part:
        -- conform.nvim will pass these arguments to the prettier CLI
        -- stylua: ignore
        prepend_args = {
          "--no-semi",
          "--arrow-parens", "avoid",
          "--print-width", "120",
          "--double-quote",
          "--trailing-comma", "all",
          "--no-use-tabs",
          "--tab-width", "2",
        },
      },
    },
    --log_level = vim.log.levels.DEBUG,
  },
}
