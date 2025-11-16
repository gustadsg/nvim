return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Get LSP capabilities from blink.cmp (loaded separately in completion/cmp.lua)
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      },
    }

    -- Ensure LSP servers are installed via mason-tool-installer.
    -- Note: do not force-install `prettier` here because installation may
    -- fail on some systems (it requires npm and network). Instead, check at
    -- runtime if a formatter is available and notify the user how to install it.
    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- Notify user if no Prettier-like formatter is available on PATH.
    local function check_prettier()
      local has_prettier = vim.fn.executable 'prettier' == 1
      local has_prettierd = vim.fn.executable 'prettierd' == 1
      if not (has_prettier or has_prettierd) then
        vim.schedule(function()
          vim.notify('Formatter not found: install `prettier` (npm) or `prettierd` (npm) for JS/TS formatting: `npm i -g prettier`', vim.log.levels.WARN)
        end)
      end
    end
    check_prettier()

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
