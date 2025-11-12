return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
    notify_on_error = false,
    formatters_by_ft = { lua = { 'stylua' } },
    format_on_save = function(bufnr)
      local disable = { c = true, cpp = true }
      if disable[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
  },
}
