local status, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

nvim_treesitter.setup {
  -- A list of parser names, or 'all'
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'java', 'lua', 'python',
    'rust', 'typescript', 'vim', 'yaml', 'json', 'dockerfile', 'sql',
  },
  auto_install = true,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true, -- `false` will disable the whole extension
    -- disable treesitter for the large files
    disable = function(_, buf)
        local max_filesize = 1024 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = { enable = true, },
  autopairs = { enable = true, },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
