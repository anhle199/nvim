return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jdtls = {
        enlabed = false,
        keys = {
          { "<leader>co", function() require("jdtls").organize_imports() end, desc = "Organize Imports" },
        },
      },
    },
    setup = {
      jdtls = function()
        return true -- avoid duplicate servers
      end,
    },
  },
}
