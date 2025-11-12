return {
  -- Treesitter support for Dockerfile syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dockerfile" })
      end
    end,
  },

  -- Mason: Install Docker-related tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
      })
    end,
  },

  -- LSP: Docker and Docker Compose language servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        },
        docker_compose_language_service = {
          filetypes = { "yaml.docker-compose" },
        },
      },
    },
  },

  -- Conform: Formatting for Dockerfiles
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        dockerfile = { "prettier" },
      },
    },
  },

  -- Nvim-lint: Linting for Dockerfiles
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
}
