return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = function()
      local harpoon = require 'harpoon'
      local telescope = require 'telescope'
      local nvim_tree = require 'nvim-tree.api'

      ---------------------------------------------------------------------------
      -- ⚙️ Main config
      ---------------------------------------------------------------------------
      harpoon:setup {
        settings = {
          save_on_toggle = true, -- saves atumatically on toggle menu
          sync_on_ui_close = true, -- syncs automatically
        },
      }

      -- Loads Telescope's extension
      telescope.load_extension 'harpoon'

      -------------------------------------      ---------------------------------------------------------------------------
      -- 🔑 Keymap
      ---------------------------------------------------------------------------
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Add current file as pointer
      keymap('n', '<leader>a', function()
        harpoon:list():add()
        vim.notify('📌 Pointer added to Harpoon!', vim.log.levels.INFO)
      end, vim.tbl_extend('force', opts, { desc = 'Add pointer toHarpoon' }))

      -- Open pointer's list with Telescope
      keymap('n', '<leader>h', function()
        telescope.extensions.harpoon.marks()
      end, vim.tbl_extend('force', opts, { desc = 'Open Pointers (Telescope)' }))

      -- Quick access to 3 first pointers
      keymap('n', '<leader>1', function()
        harpoon:list():select(1)
      end, opts)
      keymap('n', '<leader>2', function()
        harpoon:list():select(2)
      end, opts)
      keymap('n', '<leader>3', function()
        harpoon:list():select(3)
      end, opts)

      ---------------------------------------------------------------------------
      -- 🚀 Automatically opens pointers menu on Neovim start.
      -- (only if open on no specific file)
      ---------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- only if no specific file loaded
          if vim.fn.argc() == 0 then
            vim.schedule(function()
              telescope.extensions.harpoon.marks()
            end)
          end
        end,
      })
    end,
  },
}
