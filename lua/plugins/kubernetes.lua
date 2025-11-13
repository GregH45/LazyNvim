return {
  -- Treesitter support for YAML and Helm
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml", "helm" })
      end
    end,
  },

  -- Mason: Install Kubernetes-related tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "yaml-language-server",
        "helm-ls",
        "yamllint",
        "yamlfmt", -- Only used for helm/flux, not kubectl/kustomize
      })
    end,
  },

  -- LSP: YAML language server with Kubernetes schemas
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              format = {
                enable = false, -- Disable auto-format for kubectl/kustomize
              },
              validate = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                kubernetes = {
                  "*.k8s.yaml",
                  "*.k8s.yml",
                  "k8s/**/*.yaml",
                  "k8s/**/*.yml",
                },
                -- Kustomize schema from SchemaStore (verified working)
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
                -- Flux Kustomization schema (verified working)
                ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/kustomization-kustomize-v1.json"] = {
                  "**/flux-system/**/kustomization*.yaml",
                  "**/flux-system/**/kustomization*.yml",
                },
                -- Flux HelmRelease schema (verified working)
                ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrelease-helm-v2.json"] = {
                  "**/flux-system/**/*release*.yaml",
                  "**/flux-system/**/*release*.yml",
                },
                -- Flux GitRepository schema (verified working)
                -- ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/gitrepository-source-v1.json"] = {
                --   "**/flux-system/**/*gitrepository*.yaml",
                --   "**/flux-system/**/*gitrepository*.yml",
                -- },
                -- Flux HelmRepository schema (verified working)
                ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrepository-source-v1.json"] = {
                  "**/flux-system/**/*repository*.yaml",
                  "**/flux-system/**/*repository*.yml",
                },
              },
            },
          },
          filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        },
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              yamlls = {
                enabled = true,
                path = "yaml-language-server",
              },
            },
          },
          filetypes = { "helm" },
        },
      },
    },
  },

  -- Conform: Formatting only for Helm (not kubectl/kustomize)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        helm = { "yamlfmt" },
        -- Note: No 'yaml' entry here to avoid auto-formatting kubectl/kustomize
      },
    },
  },

  -- Nvim-lint: Linting for validation
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
      },
    },
  },
}
