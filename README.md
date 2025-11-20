# Nvim config
Esta configuração é um fork repositório [knickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). 

## Estrutura
```plaintext
.
├── doc
└── lua
    └── custom
        ├── config
        ├── plugins
        │   ├── completion
        │   ├── dev
        │   ├── editor
        │   ├── extras
        │   ├── git
        │   ├── lsp
        │   ├── navigation
        │   ├── search
        │   └── ui
        └── snippets
            ├── lua
            │   └── all
            └── vscode
```

- lua/custom: toda a configuração fica aqui dentro.
    - config: guarda arquivos de configuração do lazy e especificas do nvim.
    - plugins: aqui ficam as configurações dos plugins. Estão agrupadas por tipo.
    - snippets: 
        - lua: aqui ficam os snippets escritos em lua. Os snippets ficam agrupados por pastas por filetype.
        - vscode: aqui ficam snippets padrão vscode. Para adicionar um novo snippet, basta copiá-lo para essa pasta. O correto é ficar lua/custom/snippets/vscode/seu-snippet.
