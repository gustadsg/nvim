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
      -- ⚙️ Configuração principal
      ---------------------------------------------------------------------------
      harpoon:setup {
        settings = {
          save_on_toggle = true, -- salva automaticamente ao abrir/fechar menu
          sync_on_ui_close = true, -- sincroniza automaticamente
        },
      }

      -- Carrega a extensão do Telescope
      telescope.load_extension 'harpoon'

      ---------------------------------------------------------------------------
      -- 🧭 Função auxiliar: abrir ponteiro no NvimTree
      ---------------------------------------------------------------------------
      local function open_in_nvim_tree(path)
        if vim.fn.isdirectory(path) == 1 then
          nvim_tree.tree.open { path = path }
        else
          nvim_tree.tree.find_file { open = true, path = path }
        end
      end

      ---------------------------------------------------------------------------
      -- 🔑 Mapeamentos de teclas
      ---------------------------------------------------------------------------
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Adicionar arquivo/pasta atual como ponteiro
      keymap('n', '<leader>a', function()
        harpoon:list():add()
        vim.notify('📌 Pointer added to Harpoon!', vim.log.levels.INFO)
      end, vim.tbl_extend('force', opts, { desc = 'Add pointer toHarpoon' }))

      -- Abrir lista de ponteiros com Telescope
      keymap('n', '<leader>h', function()
        telescope.extensions.harpoon.marks()
      end, vim.tbl_extend('force', opts, { desc = 'Open Pointers (Telescope)' }))

      -- Abrir ponteiro atual no NvimTree
      keymap('n', '<leader>o', function()
        local mark = harpoon:list():get_current()
        if mark then
          open_in_nvim_tree(mark.value)
        else
          vim.notify('⚠️ No pointer selected.', vim.log.levels.WARN)
        end
      end, vim.tbl_extend('force', opts, { desc = 'Open pointer in NvimTree' }))

      -- Acesso rápido aos 4 primeiros ponteiros
      keymap('n', '<leader>1', function()
        harpoon:list():select(1)
      end, opts)
      keymap('n', '<leader>2', function()
        harpoon:list():select(2)
      end, opts)
      keymap('n', '<leader>3', function()
        harpoon:list():select(3)
      end, opts)
      keymap('n', '<leader>4', function()
        harpoon:list():select(4)
      end, opts)

      ---------------------------------------------------------------------------
      -- 🚀 Abre automaticamente o menu de ponteiros ao iniciar o Neovim
      -- (somente se o Neovim for aberto sem arquivo específico)
      ---------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- só abre se não houver arquivo carregado (ex: nvim sem argumentos)
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
