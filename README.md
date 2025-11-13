# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Custom Configuration

### Keymaps
- `\` - Toggle file explorer (Snacks explorer)

### Plugins & LSP Support

#### Auto-save
- **Plugin**: `okuuva/auto-save.nvim`
- Auto-saves on insert leave, text changes, focus loss
- Toggle with `:ASToggle`

#### Python Development
- **LSP**: Pyright with type checking
- **Linting**: Ruff
- **Formatting**: Black
- **Debugging**: debugpy with nvim-dap
- **Virtual Environments**: venv-selector with `<leader>cv`

#### Docker Support
- **LSP**: dockerfile-language-server, docker-compose-language-service
- **Linting**: hadolint
- **Formatting**: prettier
- **Syntax**: Treesitter for Dockerfile

#### Bash/Shell Support
- **LSP**: bash-language-server
- **Linting**: shellcheck
- **Formatting**: shfmt
- **Support**: sh, bash, zsh files

#### Kubernetes Development
- **LSP**: yaml-language-server with K8s schemas, helm-ls
- **Linting**: yamllint
- **Formatting**: yamlfmt (Helm only, not kubectl/kustomize)
- **Schemas**:
  - Kubernetes manifests (`*.k8s.yaml`, `k8s/**/*.yaml`)
  - Kustomize (`kustomization.yaml`)
  - Flux CD (HelmRelease, HelmRepository, Kustomization)
- **Note**: Auto-formatting disabled for kubectl/kustomize manifests

### File Structure
```
lua/
├── config/
│   └── keymaps.lua          # Custom keymaps
└── plugins/
    ├── autosave.lua         # Auto-save configuration
    ├── bash.lua             # Bash/shell LSP & tools
    ├── docker.lua           # Docker LSP & tools
    ├── kubernetes.lua       # K8s/Helm/Flux LSP & tools
    └── python.lua           # Python LSP & tools
```
