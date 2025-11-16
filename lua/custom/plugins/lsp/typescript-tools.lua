return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    settings = {
      -- Desabilita diagnósticos do tsserver (usa eslint quando disponível)
      diagnosticMode = 'off',
      -- Habilita sugestões automáticas de imports
      completions = {
        completeFunctionCalls = true,
      },
      -- Habilita refatorações do TypeScript
      enableLineBreakOnTypedRangeEnd = true,
      inlayHints = {
        enabled = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}
