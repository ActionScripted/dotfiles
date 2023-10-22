--[[
-- Servers: language servers and debug adapters.
-- ---
-- Lanuage servers and debug adapters provide autocomplete, linting, formatting, etc.
-- Lots of wiring here to connect servers to completion, packages, etc.
--
-- Helpful commands / related:
--  :LspInfo - Show LSP information
]]

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "icons",
          source = "if_many",
          spacing = 3,
        },
        severity_sort = true,
      },
      servers = {
        bashls = {},
        cmake = {},
        html = {},
        jsonls = {},
        lua_ls = {
          tsserver = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              -- TODO: ruff all the things
              -- https://github.com/python-lsp/python-lsp-server#configuration
              configurationSources = { "flake8", "mccabe", "pycodestyle", "pyflakes", "ruff", "ruff_lsp" },
              plugins = {
                flake8 = { enabled = true },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                --ruff_lsp = { enabled = false },
                --ruff = { enabled = false },
              },
            },
          },
        },
        terraformls = {},
        yamlls = {},
      },
    },
  },

  -- Formatters.
  -- null-ls wires things like black into lsp for auto-formatting, etc.
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.checkmake,
        --nls.builtins.diagnostics.flake8.with({
        --  -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
        --  cwd = function(params)
        --    return vim.fn.fnamemodify(params.bufname, ":h")
        --  end,
        --  diagnostics_format = "#{c}: #{m}",
        --}),
        nls.builtins.diagnostics.djlint.with({
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        nls.builtins.diagnostics.eslint_d,
        -- TODO: ignore .env files, somehow
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.formatting.beautysh.with({
          extra_args = { "--force-function-style", "fnpar", "--indent-size", "4" },
        }),
        nls.builtins.formatting.black.with({
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        nls.builtins.formatting.djlint.with({
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        nls.builtins.formatting.isort.with({
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci", "-kp" } }),
        nls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
      })
    end,
  },
}
