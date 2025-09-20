return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        enabled = false,
        keys = {
          { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
        },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
              diagnosticSeverityOverrides = {
                reportImportCycles = "error",
                reportUnusedImport = "warning",
                reportUnusedClass = "warning",
                reportUnusedFunction = "warning",
                reportUnusedVariable = "warning",
                reportDuplicateImport = "error",
                reportUnnecessaryCast = "warning",
                reportUnnecessaryComparison = "warning",
                reportUnnecessaryContains = "warning",
              },
            },
          },
        },
      },
    },
    setup = {
      pyright = function()
        return true
      end,
    },
  },
}
