local status, null_ls = pcall(require, 'null-ls')
if not status then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup {
  debug = false,
  sources = {
    completion.luasnip,

    -- js, ts
    formatting.prettier.with({ prefer_local = true }),
    diagnostics.eslint,

    -- lua
    formatting.stylua,

    -- python
    -- formatting.black.with { extra_args = { '--fast' } },
    -- diagnostics.flake8,
  },
}
