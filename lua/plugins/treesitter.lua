return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "html",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
      "css",
      "java",
      "rust",
      "sql",
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
    indent = {
      enable = true,
      disable = function(lang, bufnr)      -- Disable in large buffers
        local max_filesize = 1000 * 1024   -- 1 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return true
        end

        return lang == "python" or vim.api.nvim_buf_line_count(bufnr) > 1000
      end,
    },
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = function(lang, bufnr)      -- Disable in large buffers
        local max_filesize = 1000 * 1024   -- 1 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return true
        end

        return vim.api.nvim_buf_line_count(bufnr) > 1000
      end,
    },
  },
}
