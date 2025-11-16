return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local nvim_tree = require 'nvim-tree'

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

    local function on_attach(bufnr)
      local api = require 'nvim-tree.api'

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 🔹 Primeiro: mantém todos os atalhos padrão
      api.config.mappings.default_on_attach(bufnr)

      -- 🔹 Depois: sobrescreve só os que você quer customizar
      vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', 'o', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
      vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
    end

    nvim_tree.setup {
      on_attach = on_attach,

      update_focused_file = {
        enable = true,
        update_cwd = true,
      },

      renderer = {
        root_folder_modifier = ':t',
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = '',
            symlink = '',
            folder = {
              arrow_open = '',
              arrow_closed = '',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '',
              staged = 'S',
              unmerged = '',
              renamed = '➜',
              untracked = 'U',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        },
      },

      view = {
        width = 30,
        side = 'left',
      },
    }
  end,
}
