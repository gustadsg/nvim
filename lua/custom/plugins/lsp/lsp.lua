return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      tsserver = {
        -- Configurações TypeScript
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          map('grn', vim.lsp.buf.rename, 'LSP Rename')
          map('grr', vim.lsp.buf.references, 'LSP References')
          map('grd', vim.lsp.buf.definition, 'LSP Definition')
        end,
        settings = {
          -- Habilita sugestões automáticas de imports
          completions = { completeFunctionCalls = true },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      },
    }

    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
