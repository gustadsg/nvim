return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      local luasnip = require 'luasnip'

      -- Load snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Load custom VSCode-style snippets
      require('luasnip.loaders.from_vscode').load {
        paths = { vim.fn.stdpath 'config' .. '/lua/custom/snippets/vscode' },
        filetypes = {
          cf = { 'cfml' },
        },
      }

      -- Load custom Lua snippets
      require('luasnip.loaders.from_lua').load {
        paths = { vim.fn.stdpath 'config' .. '/lua/custom/snippets/' },
      }

      luasnip.config.set_config {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
      }
    end,
  },
}
