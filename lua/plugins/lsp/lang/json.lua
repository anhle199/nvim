return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = {
              enable = true,
            },
          },
        },
      },
    },
  },
}
