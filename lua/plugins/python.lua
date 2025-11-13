return {
  -- Treesitter support for Python syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },

  -- Mason: Install Python-related tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "black",
        "debugpy",
      })
    end,
  },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    cmd = "VenvSelect",
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
      auto_refresh = true,
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  -- LSP: Python language server with venv support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },

  -- Conform: Formatting for Python
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "black" },
      },
    },
  },

  -- Nvim-lint: Linting for Python
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },

  -- DAP: Debug adapter for Python
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
}
