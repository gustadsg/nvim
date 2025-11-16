-- Load all plugin specs from subdirectories
return {
  { import = 'custom.plugins.ui' },
  { import = 'custom.plugins.editor' },
  { import = 'custom.plugins.completion' },
  { import = 'custom.plugins.lsp' },
  { import = 'custom.plugins.git' },
  { import = 'custom.plugins.search' },
  { import = 'custom.plugins.navigation' },
  { import = 'custom.plugins.dev' },
  { import = 'custom.plugins.extras' },
}
