--[[
-- Servers: language servers and debug adapters.
-- ---
-- Language servers and debug adapters provide autocomplete, linting, formatting, etc.
-- Lots of wiring here to connect servers to completion, packages, etc.
--
-- Helpful commands / related:
--  :ConformInfo - Show Conform (formatter) information
--  :LspInfo - Show LSP information
--  :NullLsInfo - Show Null-LS (catch-all) information
]]

return {
  -- Automatic Poetry venv handling
  -- { "karloskar/poetry-nvim" },

  -- LSPs
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "icons",
          source = "if_many",
          spacing = 3,
        },
      },
      servers = {
        angularls = {},
        bashls = {},
        eslint = {},
        groovyls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              workspace = { checkThirdParty = false },
            },
          },
        },
        superhtml = {},
        pyright = {},
        ruff_lsp = {},
        terraformls = {},
        tsserver = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
            },
          },
          settings = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
              },
            },
          },
        },
        yamlls = {},
      },
    },
  },

  -- Formatters
  -- NOTE: LazyExtras may define a bunch of these elsewhere.
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        django = { "djlint" },
        fish = {},
        groovy = { "npm-groovy-lint" },
        html = { "superhtml", "prettier" },
        htmldjango = { "djlint" },
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        --sh = { "beautysh", "shfmt" },
        sh = { "shfmt" },
      },
      formatters = {
        shfmt = { prepend_args = { "-i", "4", "-ci", "-kp" } },
        stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
      },
    },
  },

  -- Linters
  -- NOTE: LazyExtras may define a bunch of these elsewhere.
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            vim.fn.expand("~/.config/markdownlint/.markdownlint.yaml"),
          },
        },
      },
      linters_by_ft = {
        make = { "checkmake" },
        terraform = { "terraform_validate", "tflint" },
      },
    },
  },
}
