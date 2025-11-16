return {
  'nvim-tree/nvim-web-devicons',
  lazy = true,
  config = function()
    require('nvim-web-devicons').setup {
      override = {},
      default = true, -- usa ícones por padrão
      color_icons = true,
      strict = true,
    }
  end,
}
